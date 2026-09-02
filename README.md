# Humanize Text Pro

An agent skill that rewrites text so it reads as written by a person: no AI tells,
no invented facts, no ambiguity.

It is a merge of three existing skills, and it exists because running them one after
another does not work.

## Credit where it belongs

This skill is built entirely on the work of three other people. Every pattern it
detects, and most of the discipline behind how it edits, came from one of these
repositories:

**[petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop)** by
[Peter Yang](https://github.com/petergyang). MIT.
The best treatment of voice preservation available in a skill. It is the one that
insists on the minimum effective edit, that tells you to leave strong human
sentences alone, and that draws the line at inventing an opinion the writer never
had. Its portability test (if a sentence could move unchanged to another company and
still read as true, it is filler) catches slop that no keyword list will. It also
ships a pass/fail eval file so the skill checks its own work, which is a genuinely
good idea that more skills should copy.

**[blader/humanizer](https://github.com/blader/humanizer)** by
[Siqi Chen](https://github.com/blader). MIT.
The most thorough catalog of AI writing patterns anywhere, grounded in
[Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing)
by WikiProject AI Cleanup. Thirty-five numbered patterns with real before-and-after
pairs. What makes it stand out is not the catalog, though: it is the
false-positive section. It tells you that polish is not proof, that one em dash
means nothing, that curly quotes come from Word and not from ChatGPT, and that
"She came. She saw. She conquered." is rhetoric rather than a defect. Very few
writing tools have that kind of restraint built in.

**[danyuchn/asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill)** by
[Dustin Yuchen Teng](https://github.com/danyuchn). MIT.
The one that solves a different problem, and the reason this merge is worth doing at
all. It adapts
[ASD-STE100 Simplified Technical English](https://www.asd-ste100.org/), the
controlled language European airlines commissioned so that maintenance instructions
could not be misread, and points it at text an agent has to parse without a human
present. Its best contribution is the modality law: a hedge carries the author's
confidence, and confidence is content, so a shorter sentence that turns "may have
failed" into "failed" is not a simplification but a different claim. The repository
is also honest about its own limits, declining to reproduce ASD's licensed
dictionary rather than pretending to full compliance.

**All three are excellent, and all three are worth using on their own.** If you only
want one, pick by problem: no-ai-slop to sharpen a draft without losing yourself,
humanizer to strip machine fingerprints from prose, asd-ste100 to make a string
unambiguous. Please star them.

**This repository takes the position that they are better combined than run in
sequence**, with the best qualities of each doing the job it is best at: no-ai-slop's
voice discipline, humanizer's pattern catalog and false-positive restraint, and
ASD-STE100's structural clarity and its refusal to weaken a hedge. That is what
Humanize Text Pro is.

## Why merging them needs work

Chain the three together and they contradict each other. This is not a criticism of
any of them. Each is internally consistent and correct for the job it was written
for. The contradictions only appear when you try to follow all three at once.

- humanizer says add opinions, use first person, let some mess in. ASD-STE100 says
  be flat and literal. no-ai-slop says never invent an opinion the writer did not
  express.
- humanizer and no-ai-slop defend long sentences and demand varied rhythm.
  ASD-STE100 caps sentences at twenty words.
- humanizer bans em dashes from the final text, then lists em dashes as a false
  positive two sections later. no-ai-slop allows one or two in a long draft.
  ASD-STE100 does not ban them at all.
- humanizer cuts excessive hedging. ASD-STE100 says never weaken a hedge.
- Two of them are suspicious of bullet lists. The third requires a list for any
  sequence of three or more steps.
- All three return a different output shape. One prints a draft, then an audit, then
  a final version. One prints the edit plus a summary of changes. One prints the
  rewritten text and nothing else.

There are fifteen of these. Each one is settled once, in
[`SKILL.md`](SKILL.md), and those rulings supersede the upstream wording.
[`references/conflict-log.md`](references/conflict-log.md) records what each source
actually said, which line lost, and why, so the reasoning is auditable rather than
asserted.

## How it resolves them

Not with a longer list of rules. By deciding what kind of text you are editing
before touching it.

| Register | For | Personality | Length caps |
|---|---|---|---|
| Voice | Blogs, essays, opinion, newsletters, narrative marketing | Required when the draft has it, never invented | Diagnostic only |
| Plain (default) | Email, Slack, docs, README, PRs, release notes, support replies | Neutral and human | Advisory |
| Precise | Error strings, tool descriptions, system prompts, agent instructions, procedures, safety text | None. Flat is correct here | Hard: 20 words for instructions, 25 for descriptions |

The register decides which rules are hard and which are advisory, which is what stops
the three sources fighting. The same skill then treats an essay and an error message
correctly instead of averaging them into something that suits neither.

Three modes on top of that:

| Mode | Trigger | Returns |
|---|---|---|
| Edit (default) | "humanize this", a pasted draft | The rewrite, plus a short list of what changed |
| Audit | "is this AI slop?", "flag the patterns" | Findings only, each with the line quoted. No rewrite, no score, no accusation |
| Clarify | "disambiguate this", "apply STE" | The rewritten text alone. Forces Precise register |

And four laws that hold in every register and every mode:

1. **Invent nothing.** No fact, name, number, date, source, cause, or frequency that
   is not in the source or supplied by the user.
2. **Keep every claim at its original strength.** "May have failed" never becomes
   "failed".
3. **The voice belongs to the writer.** Personality gets surfaced, never
   manufactured.
4. **Remove tells, do not add a costume.** Sprinkled slang and staged asides are
   tells of their own.

## Lists are allowed

Worth calling out, because it is the one ruling that overrides all three sources
rather than reconciling them.

**A bulleted or numbered list is not an AI tell, and this skill does not treat it as
one.** Use one whenever the content is genuinely a list: a sequence of three or more
steps, parallel options a reader will compare, reference material meant for lookup,
or anywhere prose would force someone to hold five items in their head at once.
Tables too.

What stays slop is decorative listing, and only these five shapes: bold
mini-heading bullets where the label is restated by its own sentence, two sentences
of prose split into two bullets for the look of it, one continuous argument chopped
into fragments, a list of one item, and emoji used as bullet markers. The test is
whether the reader gains scanning or ordering from the shape.

## What it looks like in use

Same skill, two registers, opposite treatments.

**Precise.** An error string, 38 words, five stacked hedges:

> The synchronization operation may have potentially encountered an error condition
> during the processing of the request, which could possibly be attributable to a
> mismatch in the expected configuration state that has been established by the
> upstream orchestration layer.

becomes

> The synchronization may have encountered an error while processing your request.
> The cause may be a configuration state that does not match what the upstream
> orchestration layer set.

Five hedges went and two stayed, because the system does not know whether it failed
or why. "Failed" would have been shorter and would have been a different claim.

**Voice.** A blog paragraph carrying eight patterns:

> Here's the thing, shipping fast isn't just about velocity; it's about compounding.
> At its core, what really matters is that every deploy teaches you something.
> Industry reports suggest that high-performing teams deploy more frequently.
> Ultimately, the future belongs to those who iterate.

becomes

> Shipping fast pays off through compounding, not through raw velocity. Every deploy
> teaches you something, and high-performing teams deploy more frequently.

Two things it refused to do. It did not invent a source for the last claim. It
stripped the borrowed authority and flagged the claim for a real citation.
Fabricating a plausible study name would have read better. And it did not manufacture
a voice: the register is Voice, but every distinctive-sounding phrase in that draft
was borrowed rhetoric, so there was no personality to surface. It says so instead of
bolting on staged asides.

More in [`examples/before-after.md`](examples/before-after.md), including a
full Audit-mode findings report.

## Install

A directory of Markdown plus four shell scripts. No build step, no runtime, no
dependencies beyond what your shell already has.

**Claude Code**, as a plugin:

```bash
claude plugin marketplace add sarrafgsarraf/humanize-text-pro
claude plugin install humanize-text-pro@humanize-text-pro
```

**Any harness that reads a skill directory**, by hand:

```bash
git clone https://github.com/sarrafgsarraf/humanize-text-pro.git
cp -R humanize-text-pro ~/.claude/skills/          # Claude Code
cp -R humanize-text-pro ~/.cursor/skills-cursor/   # Cursor
cp -R humanize-text-pro ~/.codex/skills/           # Codex
```

Or point your agent at the repository and ask it to install the skill globally.

**Claude CoWork** reads skills from your claude.ai account rather than from local
directories, so a file copy will not reach it. Zip the directory and upload it at
Settings, Capabilities, Skills:

```bash
zip -r -X humanize-text-pro.zip humanize-text-pro -x '*.git*' -x '*.DS_Store'
```

## Use

Invoke it by name, or just say what you want:

```
/humanize-text-pro

[paste your draft]
```

- "humanize this" runs Edit mode.
- "is this AI slop?" runs Audit mode and returns findings without rewriting.
- "rewrite this error message so an agent cannot misread it" runs Clarify mode.
- Paste a sample of your own writing first and it will match your habits instead of
  applying a house style.

Optional mechanical backstop, for the tells a regex can actually catch:

```bash
./scripts/tellscan.sh draft.md
```

Seventeen categories, dependency-free POSIX shell, exit 0 when clean and 1 when it
finds something. A clean scan is not a pass: it sees punctuation and fixed phrases,
not invented facts or a manufactured voice.

## Staying current with upstream

The three source skills are actively maintained, so this merge would rot without a
way to notice. [`.github/workflows/upstream-sync.yml`](.github/workflows/upstream-sync.yml)
runs weekly and on demand:

1. [`scripts/check-upstream.sh`](scripts/check-upstream.sh) compares the pinned SHA
   for each source in [`upstream.json`](upstream.json) against that repository's
   current default branch, using GitHub's compare API.
2. It reports only changes that touch a watched file, so unrelated upstream commits
   to a README or a workflow stay quiet.
3. On a real change, [`scripts/upstream-prepare.sh`](scripts/upstream-prepare.sh)
   bumps the pinned SHAs and writes a pull request carrying the diffs and a
   re-merge checklist.

Run it yourself any time:

```bash
./scripts/check-upstream.sh
```

**The workflow does not auto-apply upstream changes, and that is deliberate.** A
merged, conflict-resolved ruleset cannot absorb upstream prose automatically. Pasting
in new text is precisely how the fifteen contradictions arose in the first place, and
an automated append would quietly undo the work this repository exists to do. So the
automation handles the part a machine is good at, which is noticing the change,
fetching the diff, and filing it with the procedure attached. Deciding what belongs
in the merged skill stays a judgment call, made by a person or by an agent reading
the pull request.

If a scheduled run turns up a change that does not belong here, merging the PR as it
stands records that the SHA was reviewed and rejected, so the next run starts from
there rather than reporting the same diff again.

## Repository layout

| Path | What it is |
|---|---|
| [`SKILL.md`](SKILL.md) | The router. Registers, modes, four laws, fifteen conflict rulings, workflow, output contract. Loaded every invocation |
| [`references/ai-tells.md`](references/ai-tells.md) | 38 merged patterns with before and after, 18 things that only look like tells, and the human details to keep |
| [`references/clarity-rules.md`](references/clarity-rules.md) | ASD-STE100 structural and lexical rules, scoped by register, plus the modality law |
| [`references/conflict-log.md`](references/conflict-log.md) | Provenance for every ruling, the deduplication map, and the re-merge procedure |
| [`checks/eval.md`](checks/eval.md) | The exit gate. Sixty items with per-register columns, honesty items first |
| [`examples/before-after.md`](examples/before-after.md) | A worked example per register, plus an Audit-mode report |
| [`scripts/tellscan.sh`](scripts/tellscan.sh) | Mechanical tell scanner |
| [`scripts/check-upstream.sh`](scripts/check-upstream.sh) | Upstream drift detection |
| [`scripts/upstream-prepare.sh`](scripts/upstream-prepare.sh) | Builds the re-merge review PR |
| [`scripts/validate.sh`](scripts/validate.sh) | Structural checks. Run before every commit |
| [`AGENTS.md`](AGENTS.md) | How to change this skill without breaking it |

## What it will not do

- Invent a fact, source, number, cause, or frequency to make a sentence land.
- Manufacture opinions or feelings on the writer's behalf.
- Claim a text was AI-written. It names patterns; it does not accuse.
- Promise a result against any AI-detection tool. Detectors are unreliable in both
  directions, and no rewrite can be certified against them. What this delivers is
  text with no known tells and no fabricated content.
- Reproduce ASD's licensed dictionary, or certify aerospace-grade STE compliance.
- Make weak content strong. A hollow paragraph rewritten under these rules becomes a
  clean, short, well-punctuated hollow paragraph, and the skill says so instead of
  polishing it.

## Contributing

Read [`AGENTS.md`](AGENTS.md) first. The one rule that matters: never append upstream
text wholesale. Every new rule gets checked against
[`references/conflict-log.md`](references/conflict-log.md), and if a ruling already
covers the territory, you amend the ruling rather than adding a second rule that
fights the first.

Then run `./scripts/validate.sh` and make it pass.

## License

MIT, as are all three sources. [`LICENSE`](LICENSE) carries the upstream copyrights
and the third-party notice covering Wikipedia's CC BY-SA text and the ASD-STE100
redistribution restriction.

The pattern catalog derives from
[Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
maintained by WikiProject AI Cleanup. The clarity rules paraphrase the rule
categories of ASD-STE100 Issue 9 (January 2025) without reproducing the standard,
which is free to obtain from [asd-ste100.org](https://www.asd-ste100.org/) but not
free to redistribute.
