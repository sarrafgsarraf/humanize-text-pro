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

A directory of Markdown plus five POSIX shell scripts. No build step, no runtime, no
dependencies beyond what your shell already has.

```bash
git clone https://github.com/sarrafgsarraf/humanize-text-pro.git
cd humanize-text-pro
./scripts/install.sh
```

The installer detects which agents are on the machine and writes the skill to each
one's documented directory. Add `--list` to see what it found, `--dry-run` to change
nothing, `--all` to write every known path, `--project` to install into the current
repo instead of `$HOME`, or `--uninstall` to remove it.

### One copy covers eleven agents

`~/.agents/skills/` is the vendor-neutral location in the Agent Skills standard.
Codex, Cursor, Gemini CLI, GitHub Copilot, OpenCode, Amp, Goose, Junie, Roo Code,
Factory Droid, and DeepSeek Harness all read it, so if you want one command and no
reading, this is it:

```bash
mkdir -p ~/.agents/skills && cp -R humanize-text-pro ~/.agents/skills/
```

### Harnesses with native skill support

Every path below comes from that vendor's own documentation, cited in
[docs/INSTALL.md](docs/INSTALL.md#sources). Paths do change. When one is wrong, the
vendor's page is the authority, not this table.

| Harness | User level | Project level |
|---|---|---|
| **Claude Code** | `~/.claude/skills/` | `.claude/skills/` |
| **OpenAI Codex** and ChatGPT | `~/.agents/skills/`, `/etc/codex/skills/` | `.agents/skills/` (walks up to the repo root) |
| **Cursor** | `~/.cursor/skills/`, `~/.agents/skills/` | `.cursor/skills/`, `.agents/skills/` |
| **GitHub Copilot** and VS Code | `~/.copilot/skills/`, `~/.agents/skills/` | `.github/skills/`, `.claude/skills/`, `.agents/skills/` |
| **Gemini CLI** | `~/.gemini/skills/`, `~/.agents/skills/` | `.gemini/skills/`, `.agents/skills/` |
| **Google Antigravity** | `~/.gemini/config/skills/` | `.agents/skills/` |
| **DeepSeek Harness** (`dsh`) | `~/.agents/skills/` | `.agents/skills/` |
| **OpenCode** | `~/.config/opencode/skills/`, `~/.claude/skills/`, `~/.agents/skills/` | `.opencode/skills/`, `.claude/skills/`, `.agents/skills/` |
| **Amp** | `~/.config/agents/skills/`, `~/.agents/skills/`, `~/.config/amp/skills/`, `~/.claude/skills/` | `.agents/skills/`, `.claude/skills/` |
| **Goose** | `~/.agents/skills/` (recommended), `~/.claude/skills/` | `.agents/skills/`, `.goose/skills/` |
| **Hermes Agent** | `~/.hermes/skills/` | not applicable |
| **JetBrains Junie** | `~/.junie/skills/`, `~/.agents/skills/` | `.junie/skills/`, `.agents/skills/` |
| **Roo Code** | `~/.roo/skills/`, `~/.agents/skills/` | `.roo/skills/`, `.agents/skills/` |
| **Kiro** | `~/.kiro/skills/` | `.kiro/skills/` |
| **Factory Droid** | `~/.factory/skills/`, `~/.agents/skills/` | `.factory/skills/`, `.agents/skills/` |

Where a harness lists several paths it reads all of them, usually with the
harness-specific one winning a name clash. Writing to one is enough.

Claude Code also installs as a plugin, which gives you `/humanize-text-pro`:

```bash
claude plugin marketplace add sarrafgsarraf/humanize-text-pro
claude plugin install humanize-text-pro@humanize-text-pro
```

### Harnesses that install through their own CLI or account

| Harness | How |
|---|---|
| **Hermes Agent** | `hermes skills install https://raw.githubusercontent.com/sarrafgsarraf/humanize-text-pro/main/SKILL.md` |
| **Claude, Claude CoWork, claude.ai** | Skills come from your account, not from disk. `zip -r -X humanize-text-pro.zip . -x '*.git*'` then upload at Settings, Capabilities, Skills |

### Every other Agent Skills client

Around fifty products read this format. If yours is here, the skill works there.
Follow that product's own page for where its skills directory lives, then copy the
`humanize-text-pro` directory into it. Many of them also read `~/.agents/skills/`, so
try the one-copy install first.

| Client | Setup instructions |
|---|---|
| OpenHands | [docs.openhands.dev](https://docs.openhands.dev/overview/skills) |
| Mux | [mux.coder.com](https://mux.coder.com/agent-skills) |
| Letta | [docs.letta.com](https://docs.letta.com/letta-code/skills/) |
| TRAE | [trae.ai](https://www.trae.ai/blog/trae_tutorial_0115) |
| Qodo | [qodo.ai](https://www.qodo.ai/blog/how-i-use-qodos-agent-skills-to-auto-fix-issues-in-pull-requests/) |
| Tabnine | [docs.tabnine.com](https://docs.tabnine.com/main/getting-started/tabnine-cli/features/agent-skills) |
| Firebender | [docs.firebender.com](https://docs.firebender.com/multi-agent/skills) |
| Mistral AI Vibe | [github.com/mistralai/mistral-vibe](https://github.com/mistralai/mistral-vibe) |
| Deep Code (DeepSeek terminal agent) | [deepcode.vegamo.cn](https://deepcode.vegamo.cn/en/docs/configuration/agent-skills) |
| OpenClaw | [docs.openclaw.ai](https://docs.openclaw.ai/tools/skills) |
| ZeroClaw | [docs.zeroclawlabs.ai](https://docs.zeroclawlabs.ai/master/en/tools/skills.html) |
| Snowflake Cortex Code | [docs.snowflake.com](https://docs.snowflake.com/en/user-guide/cortex-code/extensibility#extensibility-skills) |
| Databricks Genie Code | [docs.databricks.com](https://docs.databricks.com/aws/en/assistant/skills) |
| VT Code | [github.com/vinhnx/vtcode](https://github.com/vinhnx/vtcode/blob/main/docs/skills/SKILLS_GUIDE.md) |
| pi | [github.com/badlogic/pi-mono](https://github.com/badlogic/pi-mono/blob/main/packages/coding-agent/docs/skills.md) |
| Emdash | [docs.emdash.sh](https://docs.emdash.sh/skills) |
| Command Code | [commandcode.ai](https://commandcode.ai/docs/skills) |
| Ona | [ona.com](https://ona.com/docs/ona/agents-md#skills-for-repository-specific-workflows) |
| Workshop | [docs.workshop.ai](https://docs.workshop.ai/core-concepts/working-with-the-agent#create-your-own-agents) |
| Autohand Code CLI | [autohand.ai](https://autohand.ai/docs/working-with-autohand-code/agent-skills.html) |
| Superconductor | [superconductor.com](https://superconductor.com/docs/project/mcp-and-skills) |
| nanobot | [nanobot.wiki](https://nanobot.wiki/docs/0.1.5/use-nanobot/skills) |
| fast-agent | [fast-agent.ai](https://fast-agent.ai/agents/skills/) |
| Pulumi Neo | [pulumi.com](https://www.pulumi.com/docs/ai/skills/) |
| Laravel Boost | [laravel.com](https://laravel.com/docs/12.x/boost#agent-skills) |
| Spring AI | [spring.io](https://spring.io/blog/2026/01/13/spring-ai-generic-agent-skills/) |
| Agentman | [agentman.ai](https://agentman.ai/agentskills) |
| Vita | [vita-ai.net](https://www.vita-ai.net/docs/features/agent-skills) |
| Google AI Edge Gallery | [github.com/google-ai-edge/gallery](https://github.com/google-ai-edge/gallery/tree/main/skills) |
| Piebald | [piebald.ai](https://piebald.ai) |

The current list of supporting products is at
[agentskills.io/clients](https://agentskills.io/clients).

### Harnesses with no skill system

These load standing instructions from a rules or context file instead of discovering
skills by description. The skill still works. You lose only the on-demand loading:
the harness reads your pointer every session and opens the skill files when the
pointer tells it to.

Install the skill into the repo, then add a pointer to the rules file:

```bash
./scripts/install.sh --project
```

| Harness | Rules file |
|---|---|
| **Windsurf** and Devin Desktop | `.windsurf/rules/*.md`, or `.devin/rules/*.md` on current builds. Legacy `.windsurfrules` still works |
| **Cline** | `.clinerules/*.md` |
| **Continue** | `.continue/rules/*.md`, or legacy `.continuerules` |
| **Zed** | `.rules` |
| **Warp** | `AGENTS.md`, or `WARP.md` for backwards compatibility |
| **Aider** | `CONVENTIONS.md`, loaded with `aider --read CONVENTIONS.md` or `read: CONVENTIONS.md` in `.aider.conf.yml` |
| **Amazon Q Developer** | `.amazonq/rules/*.md` |
| **JetBrains AI Assistant** | `.aiassistant/rules/*.md` |
| **Augment** | `AGENTS.md` |
| **Anything reading AGENTS.md** | `AGENTS.md` at the repo root |

`AGENTS.md` is the closest thing to a universal fallback. Codex, Warp, Augment, Amp,
Zed, Ona, Factory, Antigravity, and DeepSeek Harness all read it, so a harness you do
not see anywhere above will most likely pick up a pointer placed there.

[docs/INSTALL.md](docs/INSTALL.md) has the pointer block to paste, per-harness
commands, how to check the skill actually loaded, what to do when it does not, and
the source link behind every path in these tables.

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

If you fork or clone this repository, the workflow needs one repository setting to
open its PR: **Settings, Actions, General, Workflow permissions, Allow GitHub Actions
to create and approve pull requests**. GitHub turns that off by default. Without it
the workflow still pushes the branch and still reports everything, but it files an
issue with a manual compare link instead of a pull request.

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
| [`scripts/install.sh`](scripts/install.sh) | Cross-agent installer. Detects agents, writes each documented path |
| [`scripts/validate.sh`](scripts/validate.sh) | Structural checks. Run before every commit |
| [`docs/INSTALL.md`](docs/INSTALL.md) | Per-agent install instructions for ~50 coding agents |
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
