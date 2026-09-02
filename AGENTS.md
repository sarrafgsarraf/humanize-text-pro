# Guide for agents

How to change this skill without breaking it. If you are here to *use* the skill,
read `SKILL.md` instead.

## What this is

A portable agent skill: Markdown plus four POSIX shell scripts, no build step, no
dependencies. It works in any harness that reads `SKILL.md` from a directory. Keep it
that way. Do not add instructions that assume one harness's tool names, and do not
add a runtime.

## Structure and why

`SKILL.md` is loaded on every invocation. Everything in it must be worth that cost:
the register router, the four laws, the fifteen conflict rulings, the workflow, and
the output contract. It carries no pattern examples, because those belong in a file
read on demand.

The other files are progressive disclosure:

| File | Loaded when |
|---|---|
| `references/ai-tells.md` | Every Edit and Audit |
| `references/clarity-rules.md` | Plain and Precise registers |
| `references/conflict-log.md` | Someone questions a ruling, or a source publishes a new version |
| `checks/eval.md` | Before returning any Edit |
| `examples/before-after.md` | On request, or when a worked example would help |
| `scripts/tellscan.sh` | Optional mechanical scan |

Repo maintenance tooling, not loaded by the skill at runtime:

| File | Purpose |
|---|---|
| `scripts/validate.sh` | Structural checks. Run before every commit; CI runs it too |
| `scripts/check-upstream.sh` | Compares pinned SHAs in `upstream.json` against the three upstream repos |
| `scripts/upstream-prepare.sh` | Bumps pinned SHAs and writes the re-merge review PR body |
| `upstream.json` | Pinned upstream state: owner, repo, watched paths, SHA, merged version |
| `.github/workflows/validate.yml` | Runs `validate.sh` on every push and pull request |
| `.github/workflows/upstream-sync.yml` | Weekly upstream drift check that opens a review PR |

## Rules for changes

**Never append upstream text wholesale.** That is how the three sources came to
contradict each other. Every new rule gets checked against
`references/conflict-log.md` first. If a ruling already covers the territory, amend
the ruling. Do not add a second rule that fights the first.

**One ruling, one place.** A ruling lives in `SKILL.md#conflict-rulings` and is
referenced from everywhere else by link. Do not restate it in `ai-tells.md` or
`eval.md`, because a restatement drifts.

**Keep the numbering stable.** Tells in `references/ai-tells.md` are cited by number
from `checks/eval.md`, `examples/before-after.md`, and `references/conflict-log.md`.
If you renumber, fix every reference. Adding a tell at the end is cheaper.

**Every tell needs an eval item.** A pattern with no gate entry does not get checked.
Section 4 of `checks/eval.md` is the home for word and pattern items.

**Every eval item needs register columns.** V, P, X, or `soft` or `n/a`. An item
that applies everywhere unconditionally is rare; say so deliberately rather than by
omission.

**Keep the four laws inviolable.** Nothing added below them may create an exception
to them. If a new rule seems to need one, the rule is wrong.

## When a source publishes a new version

The `upstream-sync` workflow notices this for you. It runs weekly, compares each
pinned SHA in `upstream.json` against that repository's current default branch, and
opens a review pull request carrying the diffs and this procedure as a checklist.
Run the check yourself with `./scripts/check-upstream.sh`.

The workflow bumps pinned SHAs and nothing else. It never edits `SKILL.md`,
`references/`, `checks/`, or `examples/`, because absorbing upstream prose
automatically would reintroduce the fifteen contradictions this repo exists to
settle. The re-merge is yours:

1. Read every diff in the pull request in full.
2. For each changed rule, look for an existing ruling in
   `references/conflict-log.md`. Update that ruling's reasoning rather than adding a
   parallel rule.
3. New non-conflicting patterns go into `references/ai-tells.md` with the next
   number, plus an eval item in section 4 of `checks/eval.md`.
4. If the change creates a *new* contradiction with another source, add a numbered
   ruling to `SKILL.md` under Conflict rulings and record its provenance in
   `conflict-log.md`.
5. Update the version table and the dedupe map in `conflict-log.md`, then set
   `merged_version` and `last_reviewed` in `upstream.json`.
6. Run `./scripts/validate.sh`.

If nothing upstream belongs here, merge the PR as it stands. That records the SHA as
reviewed and rejected, so the next scheduled run starts from there instead of
reporting the same diff again.

To watch a different upstream file, add it to that source's `watch` array in
`upstream.json`. To track a branch other than the default, set `branch`; leaving it
`null` resolves the default branch at run time, so an upstream branch rename does not
break the check.

## Checks before publishing

One command, and CI runs the same one:

```bash
./scripts/validate.sh
```

It checks that every expected file exists, that all four scripts parse and are
executable, that the JSON manifests and the skill frontmatter are valid, that no
cross-file link or anchor is broken, that the tell numbering is contiguous and the
README's stated count matches it, that the skill's own prose contains no stray dashes
or curly quotes outside quoted examples, and that `tellscan.sh` still flags slop and
still passes clean text.

`scripts/tellscan.sh` reporting hits on `references/ai-tells.md` and
`examples/before-after.md` is expected and correct. Those files quote the patterns in
order to teach them, which is the secondhand-text exemption in
`references/ai-tells.md#what-is-not-a-tell`. `validate.sh` excludes them from its
punctuation check for that reason.

## Writing style for the skill's own prose

The skill has to obey its own rules, or it has no standing. Concretely:

- No em dashes or en dashes anywhere except inside a quoted Before example.
- No curly quotes except inside a quoted Before example.
- No emoji except inside a quoted Before example.
- Sentence case headings.
- Active voice, named actors.
- Lists where the content is a list, prose where it is not.
- One name per thing. "Tell", not tell / pattern / signal / marker.
- No sales language about the skill itself.

## Syncing to other harnesses

This repository is canonical. Mirror into each harness with a full replace, so a
file deleted upstream does not survive locally:

```bash
git clone https://github.com/sarrafgsarraf/humanize-text-pro.git /tmp/htp
for d in ~/.claude/skills ~/.cursor/skills-cursor ~/.codex/skills; do
  rm -rf "$d/humanize-text-pro"
  cp -R /tmp/htp "$d/humanize-text-pro"
  rm -rf "$d/humanize-text-pro/.git"
done
```

For Claude CoWork, rebuild the upload package. CoWork reads account-level skills
synced from claude.ai, not local directories, so a file copy will not reach it:

```bash
cd ~/.claude/skills && rm -f /tmp/humanize-text-pro.zip \
  && zip -r -X /tmp/humanize-text-pro.zip humanize-text-pro \
     -x '*.DS_Store' -x '*.git*'
```

Then upload at claude.ai, Settings, Capabilities, Skills.
