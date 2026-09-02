#!/usr/bin/env bash
# check-upstream.sh - has any of the three upstream skills changed since we merged?
#
#   ./scripts/check-upstream.sh            human-readable report
#   ./scripts/check-upstream.sh --json     machine-readable, for the sync workflow
#
# Exit 0 = every source still matches its pinned SHA.
# Exit 1 = at least one watched path changed upstream.
# Exit 2 = usage or API error.
#
# Reads upstream.json. Compares each pinned SHA against the source's branch HEAD
# using GitHub's compare API, then reports only the changes that touch a watched
# path. Needs `gh` (authenticated) and `jq`.
#
# This script REPORTS drift. It never edits SKILL.md or the reference files.
# Re-merging is a judgment call: see AGENTS.md, "When a source publishes a new
# version".

set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
MANIFEST="$ROOT/upstream.json"
JSON_OUT=0

case "${1:-}" in
"") : ;;
--json) JSON_OUT=1 ;;
-h | --help)
	sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'
	exit 0
	;;
*)
	echo "check-upstream.sh: unknown argument '$1'" >&2
	exit 2
	;;
esac

for bin in gh jq; do
	command -v "$bin" >/dev/null || {
		echo "check-upstream.sh: $bin is required" >&2
		exit 2
	}
done
[ -r "$MANIFEST" ] || {
	echo "check-upstream.sh: cannot read $MANIFEST" >&2
	exit 2
}

RESULTS='[]'
DRIFT=0

while IFS= read -r src; do
	id=$(jq -r '.id' <<<"$src")
	owner=$(jq -r '.owner' <<<"$src")
	repo=$(jq -r '.repo' <<<"$src")
	branch=$(jq -r '.branch // empty' <<<"$src")
	pinned=$(jq -r '.pinned_sha' <<<"$src")
	watch=$(jq -c '.watch' <<<"$src")

	# An absent branch means "whatever the repo's default branch is now", so an
	# upstream default-branch rename does not silently break the check.
	if [ -z "$branch" ]; then
		branch=$(gh api "repos/$owner/$repo" --jq '.default_branch' 2>/dev/null || true)
	fi
	if [ -z "$branch" ]; then
		[ "$JSON_OUT" -eq 0 ] && printf '  ERROR   %-12s cannot resolve default branch for %s/%s\n' "$id" "$owner" "$repo"
		RESULTS=$(jq --argjson r "$RESULTS" --arg id "$id" \
			'$r + [{id: $id, status: "error", detail: "cannot resolve default branch"}]' <<<'null')
		DRIFT=1
		continue
	fi

	# compare/{base}...{head} lists every file changed between the two commits.
	if ! cmp_json=$(gh api "repos/$owner/$repo/compare/$pinned...$branch" 2>/dev/null); then
		[ "$JSON_OUT" -eq 0 ] && printf '  ERROR   %-12s cannot compare %s...%s (deleted repo, renamed branch, or rewritten history?)\n' \
			"$id" "${pinned:0:7}" "$branch"
		RESULTS=$(jq --argjson r "$RESULTS" --arg id "$id" \
			'$r + [{id: $id, status: "error", detail: "compare API failed"}]' <<<'null')
		DRIFT=1
		continue
	fi

	head_sha=$(jq -r '.commits[-1].sha // empty' <<<"$cmp_json")
	[ -n "$head_sha" ] || head_sha=$pinned
	ahead=$(jq -r '.ahead_by' <<<"$cmp_json")
	compare_url=$(jq -r '.html_url' <<<"$cmp_json")

	# Keep only changed files that we actually watch.
	changed=$(jq -c --argjson w "$watch" \
		'[.files[]? | select(.filename as $f | $w | index($f)) | {file: .filename, status: .status, additions, deletions, patch: (.patch // "")}]' \
		<<<"$cmp_json")
	n=$(jq 'length' <<<"$changed")

	if [ "$n" -eq 0 ]; then
		status=current
	else
		status=drift
		DRIFT=1
	fi

	RESULTS=$(jq --argjson r "$RESULTS" \
		--arg id "$id" --arg owner "$owner" --arg repo "$repo" \
		--arg status "$status" --arg pinned "$pinned" --arg head "$head_sha" \
		--arg url "$compare_url" --argjson ahead "${ahead:-0}" --argjson changed "$changed" \
		'$r + [{id: $id, owner: $owner, repo: $repo, status: $status,
            pinned_sha: $pinned, head_sha: $head, commits_ahead: $ahead,
            compare_url: $url, changed: $changed}]' <<<'null')

	if [ "$JSON_OUT" -eq 0 ]; then
		if [ "$status" = current ]; then
			printf '  ok      %-12s %s (%s commits upstream, none touching watched paths)\n' \
				"$id" "${pinned:0:7}" "$ahead"
		else
			printf '  DRIFT   %-12s %s -> %s\n' "$id" "${pinned:0:7}" "${head_sha:0:7}"
			jq -r '.[] | "            " + .status + "  " + .file + "  (+" + (.additions|tostring) + " -" + (.deletions|tostring) + ")"' <<<"$changed"
			printf '            %s\n' "$compare_url"
		fi
	fi
done < <(jq -c '.sources[]' "$MANIFEST")

if [ "$JSON_OUT" -eq 1 ]; then
	jq -n --argjson s "$RESULTS" '{drift: ($s | map(select(.status != "current")) | length > 0), sources: $s}'
	exit 0
fi

echo
if [ "$DRIFT" -eq 0 ]; then
	echo "All three sources match their pinned SHAs. Nothing to re-merge."
	exit 0
fi

cat <<'EOF'
Upstream drift found. Do NOT paste the new text into SKILL.md or references/.

Re-merge procedure (AGENTS.md has the long form):
  1. Read the diff above.
  2. For each changed rule, check references/conflict-log.md for a ruling that
     already covers it. If one exists, decide whether the change alters the
     reasoning and amend the ruling. Never add a second rule that fights the first.
  3. Genuinely new, non-conflicting patterns go into references/ai-tells.md with
     the next number, plus a matching item in section 4 of checks/eval.md.
  4. Update the version table and dedupe map in references/conflict-log.md.
  5. Bump pinned_sha, merged_version, and last_reviewed in upstream.json.
  6. Run ./scripts/validate.sh.
EOF
exit 1
