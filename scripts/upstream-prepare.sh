#!/usr/bin/env bash
# upstream-prepare.sh - turn a check-upstream.sh --json report into a review PR.
#
#   ./scripts/check-upstream.sh --json > /tmp/report.json
#   ./scripts/upstream-prepare.sh /tmp/report.json /tmp/body.md
#
# Does two things and nothing else:
#   1. Bumps pinned_sha in upstream.json for every drifted source.
#   2. Writes the PR body, with the diffs and the re-merge checklist, to $2.
#
# It never edits SKILL.md, references/, checks/, or examples/. Re-merging upstream
# prose into a conflict-resolved ruleset is a judgment call, not a text append.
# See AGENTS.md, "When a source publishes a new version".
#
# Exit 0 = body written. Exit 3 = no drift in the report, nothing to prepare.

set -euo pipefail

REPORT=${1:?usage: upstream-prepare.sh REPORT_JSON BODY_OUT}
BODY=${2:?usage: upstream-prepare.sh REPORT_JSON BODY_OUT}
ROOT=$(cd "$(dirname "$0")/.." && pwd)
MANIFEST="$ROOT/upstream.json"
MAX_PATCH=12000 # per-file patch bytes kept in the body
MAX_BODY=60000  # GitHub caps a PR body at 65536

command -v jq >/dev/null || {
	echo "upstream-prepare.sh: jq is required" >&2
	exit 2
}
[ -r "$REPORT" ] || {
	echo "upstream-prepare.sh: cannot read $REPORT" >&2
	exit 2
}

[ "$(jq -r '.drift' "$REPORT")" = true ] || {
	echo "upstream-prepare.sh: report shows no drift"
	exit 3
}

# 1. Bump the pinned SHAs for drifted sources only.
jq --slurpfile r "$REPORT" '
  .sources |= map(
    . as $s
    | (($r[0].sources[] | select(.id == $s.id)) // {}) as $found
    | if ($found.status // "current") == "drift"
      then .pinned_sha = $found.head_sha
      else . end
  )' "$MANIFEST" >"$MANIFEST.tmp"
mv "$MANIFEST.tmp" "$MANIFEST"

# 2. Build the body.
{
	cat <<'INTRO'
One or more of the three upstream skills changed since the last re-merge.

**This PR bumps `upstream.json` only.** It does not touch `SKILL.md`,
`references/`, `checks/`, or `examples/`. Do not merge it as a content update.
Read the diffs, decide what actually belongs in the merged ruleset, and make
those edits on this branch first.

Why this is not automatic: the three sources contradict each other in fifteen
places, and pasting in new upstream text is exactly how those contradictions
arose. The workflow does the part a machine is good at, which is noticing the
change and filing it with a checklist.

## What changed upstream

INTRO

	jq -r --argjson maxp "$MAX_PATCH" '
    .sources[] | select(.status != "current") |
    "### " + .id + " (" + (.owner // "?") + "/" + (.repo // "?") + ")\n"
    + (if .status == "error" then
         "Could not compare against upstream: " + (.detail // "unknown error") + ".\n"
         + "Check whether the repo was renamed, deleted, or had its history rewritten.\n"
       else
         "Pinned `" + .pinned_sha[0:7] + "` to upstream `" + .head_sha[0:7] + "`, "
         + (.commits_ahead|tostring) + " commits ahead.\n"
         + "[Full compare on GitHub](" + .compare_url + ")\n\n"
         + "Watched files that changed:\n\n"
         + ([.changed[] | "- `" + .file + "` " + .status
             + " (+" + (.additions|tostring) + " -" + (.deletions|tostring) + ")"] | join("\n"))
         + "\n\n"
         + ([.changed[]
             | "<details><summary>Patch: " + .file + "</summary>\n\n```diff\n"
               + (.patch[0:$maxp])
               + (if (.patch|length) > $maxp then "\n... patch truncated, use the compare link above" else "" end)
               + "\n```\n\n</details>"] | join("\n\n"))
         + "\n"
       end)
  ' "$REPORT"

	cat <<'CHECKLIST'

## Re-merge checklist

The long form is in [AGENTS.md](AGENTS.md#when-a-source-publishes-a-new-version).

- [ ] Read each diff above in full.
- [ ] For every changed rule, check [`references/conflict-log.md`](references/conflict-log.md) for a ruling that already covers that territory. If one exists, decide whether the change alters the reasoning and **amend the ruling**. Never add a second rule that fights the first.
- [ ] Genuinely new, non-conflicting patterns go into [`references/ai-tells.md`](references/ai-tells.md) with the next number, plus a matching item in section 4 of [`checks/eval.md`](checks/eval.md).
- [ ] If the change creates a *new* contradiction with another source, add a numbered ruling to [`SKILL.md`](SKILL.md) under Conflict rulings and record its provenance in `conflict-log.md`.
- [ ] Update the version table and dedupe map in `conflict-log.md`, then set `merged_version` and `last_reviewed` in `upstream.json`.
- [ ] Run `./scripts/validate.sh` and make it pass.

If nothing upstream belongs in the merged skill, merge this PR as it stands. It
records that the new upstream SHA was reviewed and rejected, so the next
scheduled run starts from there instead of reporting the same change again.
CHECKLIST
} >"$BODY"

# Keep inside GitHub's PR body limit.
if [ "$(wc -c <"$BODY")" -gt "$MAX_BODY" ]; then
	head -c $((MAX_BODY - 200)) "$BODY" >"$BODY.trim"
	printf '\n\n_Body truncated. Use the compare links above for the complete diffs._\n' >>"$BODY.trim"
	mv "$BODY.trim" "$BODY"
fi

printf 'upstream.json bumped; PR body written to %s (%s bytes)\n' "$BODY" "$(wc -c <"$BODY" | tr -d ' ')"
