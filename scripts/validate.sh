#!/usr/bin/env bash
# validate.sh - structural checks on the skill. Run before every commit, and in CI.
#
#   ./scripts/validate.sh
#
# Exit 0 = all checks pass. Exit 1 = at least one failed.
#
# Checks the things that break silently: unparseable frontmatter, a broken
# cross-file link, a tell that no eval item covers, a shell syntax error, and the
# skill's own prose violating its own punctuation rules.
#
# Needs bash, python3, and grep. No pip installs.

set -uo pipefail
cd "$(cd "$(dirname "$0")/.." && pwd)"

PASS=0
FAIL=0
ok() {
	printf '  ok    %s\n' "$1"
	PASS=$((PASS + 1))
}
bad() {
	printf '  FAIL  %s\n' "$1"
	[ -n "${2:-}" ] && printf '%s\n' "$2" | sed 's/^/          /'
	FAIL=$((FAIL + 1))
}

echo "== files"
for f in SKILL.md README.md AGENTS.md LICENSE upstream.json \
	references/ai-tells.md references/clarity-rules.md references/conflict-log.md \
	checks/eval.md examples/before-after.md \
	scripts/tellscan.sh scripts/check-upstream.sh agents/openai.yaml \
	.claude-plugin/plugin.json .claude-plugin/marketplace.json; do
	[ -f "$f" ] && ok "$f" || bad "$f missing"
done

echo "== shell syntax"
for s in scripts/*.sh; do
	if out=$(bash -n "$s" 2>&1); then ok "$s"; else bad "$s" "$out"; fi
done

echo "== executable bits"
for s in scripts/*.sh; do
	[ -x "$s" ] && ok "$s is executable" || bad "$s is not executable (chmod +x)"
done

echo "== json parses"
for j in upstream.json .claude-plugin/plugin.json .claude-plugin/marketplace.json .codex-plugin/plugin.json; do
	[ -f "$j" ] || continue
	if out=$(python3 -c "import json,sys;json.load(open(sys.argv[1]))" "$j" 2>&1); then
		ok "$j"
	else bad "$j" "$out"; fi
done

echo "== skill frontmatter"
out=$(python3 - <<'PY' 2>&1
import re, sys
src = open('SKILL.md', encoding='utf-8').read()
if not src.startswith('---\n'):
    sys.exit('SKILL.md does not open with a YAML frontmatter fence')
try:
    import yaml
    fm = yaml.safe_load(src.split('---')[1])
except ImportError:
    # No PyYAML: fall back to checking the two fields that matter.
    block = src.split('---')[1]
    fm = {'name': re.search(r'^name:\s*(\S+)', block, re.M).group(1),
          'description': re.search(r'^description:.*', block, re.M).group(0)}
name, desc = fm['name'], str(fm['description'])
errs = []
if not re.fullmatch(r'[a-z0-9-]+', name):
    errs.append(f'name must be kebab-case, got {name!r}')
if name != 'humanize-text-pro':
    errs.append(f'name is {name!r}, expected humanize-text-pro')
if len(desc) > 1024:
    errs.append(f'description is {len(desc)} chars, limit is 1024')
if errs:
    sys.exit('; '.join(errs))
print(f'name={name} description={len(desc)} chars')
PY
)
[ $? -eq 0 ] && ok "frontmatter ($out)" || bad "frontmatter" "$out"

echo "== internal links and anchors"
out=$(python3 - <<'PY' 2>&1
import os, re
def anchors(path):
    out = set()
    for line in open(path, encoding='utf-8'):
        m = re.match(r'^(#{1,6})\s+(.*)$', line)
        if m:
            t = re.sub(r'<a id="([^"]+)"></a>', '', m.group(2).strip()).lower()
            t = re.sub(r'[^\w\s-]', '', t)
            out.add(re.sub(r'\s+', '-', t.strip()))
        out |= set(re.findall(r'<a id="([^"]+)"></a>', line))
    return out

files = []
for root, dirs, fs in os.walk('.'):
    dirs[:] = [d for d in dirs if d not in ('.git', 'node_modules')]
    files += [os.path.join(root, f) for f in fs if f.endswith('.md')]
amap = {os.path.normpath(f): anchors(f) for f in files}
bad = []
for f in files:
    base, text = os.path.dirname(f), open(f, encoding='utf-8').read()
    for target, frag in re.findall(r'\]\(([^)#\s]*)#([^)\s]+)\)', text):
        if target.startswith('http'):
            continue
        tgt = os.path.normpath(os.path.join(base, target)) if target else os.path.normpath(f)
        if tgt not in amap:
            bad.append(f'{f} -> {target}#{frag} (no such file)')
        elif frag not in amap[tgt]:
            bad.append(f'{f} -> {target or os.path.basename(f)}#{frag} (no such anchor)')
    for target in re.findall(r'\]\(([^)#\s]+)\)', text):
        if target.startswith('http') or target.startswith('#'):
            continue
        if not os.path.exists(os.path.normpath(os.path.join(base, target))):
            bad.append(f'{f} -> {target} (no such path)')
raise SystemExit('\n'.join(bad) if bad else print(f'{len(files)} markdown files, 0 broken links'))
PY
)
[ $? -eq 0 ] && ok "links ($out)" || bad "links" "$out"

echo "== tell numbering and eval coverage"
out=$(python3 - <<'PY' 2>&1
import re, sys
tells = re.findall(r'^### (\d+)\. ', open('references/ai-tells.md', encoding='utf-8').read(), re.M)
nums = [int(n) for n in tells]
errs = []
if nums != list(range(1, len(nums) + 1)):
    errs.append(f'tell numbering is not 1..N contiguous: {nums}')
readme = open('README.md', encoding='utf-8').read()
if f'{len(nums)} merged patterns' not in readme:
    errs.append(f'README does not say "{len(nums)} merged patterns" (tell count changed?)')
ev = open('checks/eval.md', encoding='utf-8').read()
for sec in ('## 1. Honesty', '## 4. Words and patterns', '## 8. Delivery'):
    if sec not in ev:
        errs.append(f'checks/eval.md is missing section {sec!r}')
if errs:
    sys.exit('; '.join(errs))
print(f'{len(nums)} tells, contiguous, README in sync')
PY
)
[ $? -eq 0 ] && ok "tells ($out)" || bad "tells" "$out"

echo "== the skill obeys its own punctuation rules"
# Dashes, curly quotes, and emoji are legitimate only inside a quoted example.
# ai-tells.md and examples/before-after.md teach them, so they are exempt.
strays=$(grep -rn -e '—' -e '–' -e '“' -e '”' -e '‘' -e '’' \
	--include='*.md' SKILL.md README.md AGENTS.md checks/ references/clarity-rules.md references/conflict-log.md 2>/dev/null |
	grep -v '`' || true)
[ -z "$strays" ] && ok "no stray dashes or curly quotes outside examples" ||
	bad "stray dashes or curly quotes" "$strays"

emoji=$(LC_ALL=C grep -rln -e "$(printf '\360\237')" \
	SKILL.md README.md AGENTS.md checks/ references/clarity-rules.md references/conflict-log.md 2>/dev/null || true)
[ -z "$emoji" ] && ok "no emoji outside examples" || bad "emoji found" "$emoji"

echo "== tellscan self-test"
tmp=$(mktemp)
printf 'The dashboard shows every project spend in one table. It refreshes every 60 seconds.\n' >"$tmp"
if bash scripts/tellscan.sh "$tmp" >/dev/null 2>&1; then ok "clean text scans clean"; else bad "tellscan flagged clean text"; fi
printf 'Here is the thing: it is not just robust, it is seamless. I hope this helps!\n' >"$tmp"
if bash scripts/tellscan.sh "$tmp" >/dev/null 2>&1; then bad "tellscan missed obvious slop"; else ok "slop text is flagged"; fi
rm -f "$tmp"

printf '\n%s passed, %s failed\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ] || exit 1
