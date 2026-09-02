#!/usr/bin/env bash
# install.sh - install this skill for every coding agent on this machine.
#
#   ./scripts/install.sh                 install globally for detected agents
#   ./scripts/install.sh --all           install to every known path, detected or not
#   ./scripts/install.sh --project       install into the current repo instead of $HOME
#   ./scripts/install.sh --dry-run       print what would happen, change nothing
#   ./scripts/install.sh --list          list every known agent path and its status
#   ./scripts/install.sh --uninstall     remove the skill from every known path
#
# Run it from a checkout of the repository. Nothing is downloaded and nothing is
# executed from the network.
#
# Most agents read the vendor-neutral ~/.agents/skills/ directory, so that one is
# always installed. The rest are per-agent paths, taken from each vendor's own
# documentation. See docs/INSTALL.md for the sources and for agents that have no
# skill system.

set -euo pipefail

SKILL=humanize-text-pro
SRC=$(cd "$(dirname "$0")/.." && pwd)

MODE=install
SCOPE=global
FORCE_ALL=0
DRY=0

while [ $# -gt 0 ]; do
	case "$1" in
	--all) FORCE_ALL=1 ;;
	--project) SCOPE=project ;;
	--dry-run) DRY=1 ;;
	--list) MODE=list ;;
	--uninstall) MODE=uninstall ;;
	-h | --help)
		sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
		exit 0
		;;
	*)
		echo "install.sh: unknown argument '$1' (try --help)" >&2
		exit 2
		;;
	esac
	shift
done

[ -f "$SRC/SKILL.md" ] || {
	echo "install.sh: $SRC/SKILL.md not found. Run this from a checkout of the repo." >&2
	exit 2
}

# "label|path|kind" where kind is shared (many agents read it) or the agent's own.
# Paths come from each vendor's documentation; docs/INSTALL.md cites every one.
global_targets() {
	cat <<-EOF
		Cross-agent standard|$HOME/.agents/skills|shared
		Claude Code, OpenCode, Amp, Goose, Cursor|$HOME/.claude/skills|shared
		Amp (XDG config)|$HOME/.config/agents/skills|own
		Cursor|$HOME/.cursor/skills|own
		OpenAI Codex (legacy path)|$HOME/.codex/skills|own
		GitHub Copilot|$HOME/.copilot/skills|own
		Gemini CLI|$HOME/.gemini/skills|own
		Google Antigravity|$HOME/.gemini/config/skills|own
		OpenCode|$HOME/.config/opencode/skills|own
		Hermes Agent|$HOME/.hermes/skills|own
		JetBrains Junie|$HOME/.junie/skills|own
		Roo Code|$HOME/.roo/skills|own
		Kiro|$HOME/.kiro/skills|own
		Factory Droid|$HOME/.factory/skills|own
		Goose (config dir)|$HOME/.config/goose/skills|own
		Amp (config dir)|$HOME/.config/amp/skills|own
	EOF
}

project_targets() {
	cat <<-EOF
		Cross-agent standard|$PWD/.agents/skills|shared
		Claude Code, OpenCode, Amp, Goose, Copilot|$PWD/.claude/skills|shared
		Cursor|$PWD/.cursor/skills|own
		GitHub Copilot|$PWD/.github/skills|own
		Gemini CLI|$PWD/.gemini/skills|own
		OpenCode|$PWD/.opencode/skills|own
		JetBrains Junie|$PWD/.junie/skills|own
		Roo Code|$PWD/.roo/skills|own
		Kiro|$PWD/.kiro/skills|own
		Factory Droid|$PWD/.factory/skills|own
		Goose|$PWD/.goose/skills|own
	EOF
}

targets() { [ "$SCOPE" = project ] && project_targets || global_targets; }

# Copy the skill, minus VCS and packaging noise, into <dir>/$SKILL.
place() {
	dest=$1/$SKILL
	if [ "$DRY" -eq 1 ]; then
		echo "    would install -> $dest"
		return
	fi
	mkdir -p "$1"
	rm -rf "$dest"
	mkdir -p "$dest"
	# tar keeps modes (the scripts must stay executable) and honours excludes.
	# .github ships too: it keeps an installed copy a faithful mirror that still
	# passes scripts/validate.sh, and the workflows are inert outside a repo root.
	(cd "$SRC" && tar -cf - \
		--exclude .git \
		--exclude .gitignore \
		--exclude '*.zip' \
		--exclude .DS_Store \
		.) | (cd "$dest" && tar -xf -)
	echo "    installed -> $dest"
}

case "$MODE" in
list)
	printf '%-42s %-10s %s\n' "PATH" "PRESENT" "AGENT"
	while IFS='|' read -r label path kind; do
		[ -n "${path:-}" ] || continue
		if [ -d "$path/$SKILL" ]; then st=installed
		elif [ -d "$path" ]; then st=dir
		elif [ -d "$(dirname "$path")" ]; then st=parent
		else st=no; fi
		printf '%-42s %-10s %s\n' "${path/#$HOME/~}" "$st" "$label"
	done < <(targets)
	echo
	echo "installed = skill already there. dir = skills dir exists. parent = agent"
	echo "config dir exists but no skills dir yet. no = agent not found on this machine."
	exit 0
	;;
uninstall)
	n=0
	while IFS='|' read -r label path kind; do
		[ -n "${path:-}" ] || continue
		if [ -d "$path/$SKILL" ]; then
			if [ "$DRY" -eq 1 ]; then
				echo "  would remove $path/$SKILL"
			else
				rm -rf "$path/$SKILL"
				echo "  removed $path/$SKILL"
			fi
			n=$((n + 1))
		fi
	done < <(targets)
	echo
	[ "$n" -gt 0 ] && echo "Removed from $n location(s)." || echo "Nothing to remove."
	echo "Claude CoWork and Hermes installs made through their own CLI or web UI"
	echo "are not touched. Remove those the same way you added them."
	exit 0
	;;
esac

echo "Installing $SKILL from $SRC"
[ "$SCOPE" = project ] && echo "Scope: this project ($PWD)" || echo "Scope: global (\$HOME)"
[ "$FORCE_ALL" -eq 1 ] && echo "Mode: --all, writing every known path"
[ "$DRY" -eq 1 ] && echo "Mode: --dry-run, nothing will change"
echo

installed=0
skipped=0
while IFS='|' read -r label path kind; do
	[ -n "${path:-}" ] || continue

	# The cross-agent path is the one most agents read, so it always gets written.
	# Others are written when --all is set, when the skills dir already exists, or
	# when the agent's config dir exists (meaning the agent is installed here).
	want=0
	if [ "$kind" = shared ] || [ "$FORCE_ALL" -eq 1 ]; then
		want=1
	elif [ -d "$path" ] || [ -d "$(dirname "$path")" ]; then
		want=1
	fi

	if [ "$want" -eq 1 ]; then
		echo "  $label"
		place "$path"
		installed=$((installed + 1))
	else
		skipped=$((skipped + 1))
	fi
done < <(targets)

echo
echo "Wrote $installed location(s); skipped $skipped agent(s) not found on this machine."
echo "Run with --all to write those too, or --list to see them."

cat <<'NEXT'

Two agents need a step this script cannot do for you:

  Claude CoWork / claude.ai   Skills come from your account, not from disk. Zip the
                              directory and upload it at Settings > Capabilities >
                              Skills:
                                zip -r -X humanize-text-pro.zip . -x '*.git*'

  Hermes Agent                Installs through its own CLI:
                                hermes skills install \
                                  https://raw.githubusercontent.com/sarrafgsarraf/humanize-text-pro/main/SKILL.md
                              (or copy the directory into ~/.hermes/skills/, which
                              this script already did if that directory existed)

Agents with no skill system (Windsurf, Cline, Aider, Continue, Zed, Warp and
friends) load it through a rules or context file instead. docs/INSTALL.md has the
one-line recipe for each.

Verify it loaded by asking your agent: "list your available skills" or
"humanize this: Here's the thing, our robust platform leverages cutting-edge AI."
NEXT
