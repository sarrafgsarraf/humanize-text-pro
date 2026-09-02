#!/bin/sh
# tellscan.sh - grep for the AI tells a regex can actually catch.
#
#   ./tellscan.sh draft.md          scan a file
#   pbpaste | ./tellscan.sh         scan stdin
#
# Exit 0 = no mechanical tells found. Exit 1 = tells found (listed on stdout).
# Exit 2 = usage error.
#
# This is a backstop, not a verdict. It catches punctuation and fixed phrases.
# It cannot see inflated significance, invented facts, forced triples, portability
# failures, or a manufactured voice. A clean scan is not a pass: run checks/eval.md.
#
# POSIX sh + BSD/GNU grep only. No dependencies.

set -u

usage() {
	echo "usage: tellscan.sh [FILE]   (reads stdin when FILE is omitted)" >&2
	exit 2
}

[ $# -gt 1 ] && usage
case "${1:-}" in -h | --help) usage ;; esac

if [ $# -eq 1 ]; then
	[ -r "$1" ] || {
		echo "tellscan.sh: cannot read $1" >&2
		exit 2
	}
	SRC=$1
	CLEANUP=
else
	SRC=$(mktemp "${TMPDIR:-/tmp}/tellscan.XXXXXX") || exit 2
	cat >"$SRC"
	CLEANUP=$SRC
fi

FOUND=0

# report LABEL then the matching "line:text" pairs on stdin
report() {
	if [ -n "${2:-}" ]; then
		printf '\n== %s\n%s\n' "$1" "$2"
		FOUND=1
	fi
}

# Literal-character tells. Passed with -e so no regex metacharacters apply.
report "em / en dash (ruling 3)" \
	"$(grep -n -e '—' -e '–' "$SRC")"

# A spaced hyphen only counts as a dash substitute when a word precedes it, so
# nested markdown list items ("  - item") do not match.
report "spaced dash or double hyphen used as a dash (tell 24)" \
	"$(grep -n -E '[[:alnum:],.)"'"'"']( --? )' "$SRC")"

report "curly quotes: check they match the destination (ruling 9)" \
	"$(grep -n -e '“' -e '”' -e '‘' -e '’' "$SRC")"

report "semicolon (ruling 4: banned in Precise, rare elsewhere)" \
	"$(grep -n ';' "$SRC")"

# Emoji. Matched by UTF-8 byte prefix under the C locale, which is the only form
# that works in both BSD and GNU grep. Covers U+1F300-U+1FAFF plus the pictograph
# and dingbat blocks that supply most decorative emoji.
report "emoji (tell 27)" \
	"$(LC_ALL=C grep -n \
		-e "$(printf '\360\237')" \
		-e "$(printf '\342\234')" \
		-e "$(printf '\342\235')" \
		-e "$(printf '\342\234\205')" "$SRC")"

# Fixed phrases. Case-insensitive, word-ish boundaries where it matters.
report "chatbot residue (tell 30)" \
	"$(grep -n -i -E "i hope this helps|let me know if|great question|you're absolutely right|you are absolutely right|would you like me to|want me to|should i continue|feel free to (ask|reach out)|certainly!|of course!" "$SRC")"

report "throat-clearing / announcements (tell 31)" \
	"$(grep -n -i -E "here'?s the thing|the thing is,|let me be clear|i'?ll be honest|let'?s be honest|real talk|let'?s (dive|explore|break this down)|here'?s what you need to know|without further ado|now let'?s look at" "$SRC")"

report "faux insight / pretended depth (tell 32)" \
	"$(grep -n -i -E "the real question is|at its core|what really matters|the deeper issue|the heart of the matter|what (most people|nobody|everyone) (get|miss|tell)|the part everyone misses|the uncomfortable truth|what if i told you|plot twist:" "$SRC")"

report "inflated significance (tell 1)" \
	"$(grep -n -i -E "(stands|serves) as|is a testament|pivotal moment|(vital|crucial|pivotal|key) (role|moment)|underscor(es|ing) (its|the) (importance|significance)|reflects (a )?broader|evolving landscape|indelible mark|solidifies its position|marks a (shift|turning point)" "$SRC")"

report "sales language (tell 2)" \
	"$(grep -n -i -E "seamless|robust|cutting-edge|game.?chang|paradigm shift|boasts a|nestled|in the heart of|breathtaking|must-visit|world-class|best-in-class|next-generation|effortless|blazing.?fast" "$SRC")"

report "overused AI vocabulary (tell 18)" \
	"$(grep -n -i -E "\bdelve|\bleverag(e|ing)|\butiliz|\bfoster(s|ing)?\b|\bempower|\bstreamlin|\btapestry|\brealm\b|\bmultifaceted|\bmeticulous|\bparamount|\btransformative|\bunderscore|\bshowcas|\bintricac|\bever-evolving|\bsupercharge|\bembark\b|\belevate\b|\bharness(es|ing)? (the|its|this|their|our)\b" "$SRC")"

report "vague sources (tell 8)" \
	"$(grep -n -i -E "experts (agree|say|argue|believe)|industry reports?|studies show|research suggests|observers have (noted|cited)|(many|some) (argue|critics)|widely regarded as" "$SRC")"

report "shallow trailing -ing analysis (tell 4)" \
	"$(grep -n -i -E ", (highlighting|underscoring|emphasizing|reflecting|symbolizing|showcasing|demonstrating|signaling|cementing|contributing to|ensuring|fostering|cultivating|encompassing)" "$SRC")"

report "filler phrases (tell 36)" \
	"$(grep -n -i -E "it'?s (important|worth) (to )?not(e|ing)|in order to|due to the fact that|at this point in time|in the event that|has the ability to|at the end of the day|when it comes to|in today'?s world|in the age of|going forward" "$SRC")"

report "stacked hedging (tell 37)" \
	"$(grep -n -i -E "could potentially|might arguably|it could be argued|may possibly|possibly be|in some cases it may|it is also possible" "$SRC")"

report "generic positive ending / recap (tell 38)" \
	"$(grep -n -i -E "in conclusion|^ *(ultimately|overall),|the future looks bright|exciting times|step in the right direction|journey toward" "$SRC")"

report "bold mini-heading bullet (tell 26)" \
	"$(grep -n -E "^ *[-*+] +\*\*[^*]+:?\*\*:? " "$SRC")"

[ -n "$CLEANUP" ] && rm -f "$CLEANUP"

if [ "$FOUND" -eq 0 ]; then
	echo "No mechanical tells found. This is not a pass: run checks/eval.md."
	exit 0
fi

printf '\n%s\n' "Mechanical tells above. Some are legitimate in context:
  - a watched phrase inside a quotation, title, proper name, or example
  - curly quotes in typeset prose, straight quotes in code
  - one semicolon or dash in long-form Voice register
  - established technical usage of a watched word
Check references/ai-tells.md#what-is-not-a-tell before cutting anything."
exit 1
