---
name: humanize-text-pro
version: 1.0.0
description: >-
  Rewrite text so it reads as written by a person, with no AI tells, no invented
  facts, and no ambiguity. Use when the user asks to humanize, de-slop, naturalize,
  or clean up writing; asks whether a draft reads as AI; asks for a plain-language,
  disambiguating, or Simplified Technical English rewrite of a tool description,
  error message, system prompt, or agent instruction; or before drafting or sending
  any customer- or user-facing message (email, Slack or Teams message, support
  reply, release notes, public announcement, marketing copy). Also use when a draft
  needs to be sharper, more direct, or more opinionated while keeping the writer's
  own voice. Combines petergyang/no-ai-slop, blader/humanizer, and
  danyuchn/asd-ste100-skill into one non-conflicting ruleset.
license: MIT
metadata:
  short-description: One ruleset for human-sounding, unambiguous, honest prose
  combines:
    - petergyang/no-ai-slop
    - blader/humanizer (Wikipedia "Signs of AI writing")
    - danyuchn/asd-ste100-skill (ASD-STE100 Issue 9)
---

# Humanize Text Pro

One editor, one ruleset. This skill merges three upstream skills that each solved
part of the problem and disagreed on the rest:

| Source | What it contributes |
|---|---|
| [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop) | Voice preservation, minimum effective edit, slop patterns, a pass/fail self-check |
| [blader/humanizer](https://github.com/blader/humanizer) | The Wikipedia "Signs of AI writing" catalog, false-positive discipline, human details worth keeping |
| [danyuchn/asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill) | ASD-STE100 structural clarity: one meaning per word, one instruction per sentence, modality preservation |

They conflict in fifteen places. Every conflict is settled once, in
[Conflict rulings](#conflict-rulings). **Those rulings supersede the upstream
wording in all three source skills.** Do not go back to a source rule that a
ruling has overridden, and do not apply two sources' contradictory advice in the
same pass.

## The four laws

These hold in every register, every mode, every time. Nothing below overrides them.

1. **Invent nothing.** Never add a fact, name, number, date, statistic, quote,
   citation, source, cause, frequency, or ranking that is not in the source or
   supplied by the user. If a sentence reads better because you supplied a
   mechanism, you have stopped editing and started writing fiction. Ask for the
   missing detail or use a simpler sentence. (Fiction and creative writing are
   exempt, because invented detail is the job there.)
2. **Keep every claim, and keep it at its original strength.** You may cut dull
   passages, expand useful ones, and merge or split paragraphs. You may not drop
   information, and you may not promote a hedge to a fact. "The request may have
   failed" never becomes "the request failed."
3. **The voice belongs to the writer, not to you.** Surface the personality that
   is already in the draft. Never manufacture an opinion, a feeling, or a
   confession the writer did not express. If the piece needs a voice it does not
   have, ask for one.
4. **Remove tells, do not add a costume.** The goal is prose with no machine
   fingerprints. It is not prose performing humanity. Sprinkled slang, staged
   asides, and fake candour are AI tells of their own.

## Step 1: pick the register

Read the text and decide which of three registers it belongs to. Say the choice
out loud only in Audit mode or when the user asks. The register decides which
rules are hard and which are advisory, and it is the mechanism that keeps the
three sources from fighting.

| Register | Text types | Personality | Sentence length | Clarity rules |
|---|---|---|---|---|
| **Voice** | Blog posts, essays, opinion, newsletters, personal writing, narrative marketing, social posts | Required when the draft has it. Never invented. | Variety required. Caps are diagnostic only. | Structural rules advisory |
| **Plain** (default) | Email, Slack or Teams, support replies, docs, README, PR descriptions, release notes, changelogs, internal memos, reports | Neutral and human. Warmth yes, performance no. | Variety preferred. Caps advisory. | Structural rules apply, softly |
| **Precise** | Error strings, tool and function descriptions, system prompts, inter-agent instructions, procedures, safety text, API reference, config comments, UI microcopy | None. Flat and literal is correct here. | Hard caps: 20 words for instructions, 25 for descriptions | Structural rules mandatory |

When the text mixes registers (a README with a procedure inside it), split it and
apply each register to its own part. When you genuinely cannot tell, use Plain.

## Step 2: pick the mode

| Mode | Trigger | What you return |
|---|---|---|
| **Edit** (default) | "humanize this", "clean this up", "make this sharper", a pasted draft | The rewritten text, plus a short **What changed** list |
| **Audit** | "is this AI?", "does this read as AI slop", "flag the patterns", "scan this", "review without rewriting" | Findings only. Do not rewrite. |
| **Clarify** | "disambiguate this", "apply STE", "plain-language rewrite", "rewrite so an agent cannot misread this" | The rewritten text alone. Forces Precise register. |

**Audit mode rules.** Name each pattern found, quote the offending line, and give
the fix in a few words. Do not rewrite the draft, do not score it out of ten, and
do not claim to know whether an AI wrote it. Detectors guess; named patterns are
evidence the writer can check. Offer to edit afterwards.

## Conflict rulings

Fifteen places where the sources contradict each other. Each ruling is final.

### 1. Personality versus flatness
humanizer says add opinions, first person, and mess. no-ai-slop says preserve the
writer's voice and invent nothing. STE100 says be flat and literal.

**Ruling:** the register decides how much voice, and law 3 decides whose voice.
Voice register keeps and sharpens the personality already in the draft. Plain
register stays neutral and human. Precise register has no personality at all.
In no register do you invent an opinion. humanizer's "add soul" is scoped to
Voice register only, and even there it means *surface*, never *supply*.

### 2. Sentence length
humanizer and no-ai-slop want varied rhythm and defend long sentences. STE100
caps sentences at 20 or 25 words.

**Ruling:** in Precise, the caps are hard. In Voice and Plain, they are a
diagnostic: a sentence over 25 words gets read once for tangling, then kept if it
is clear. Never split a clear long sentence to hit a number. Do split one that
carries three unrelated ideas. Uniform mid-length sentences are themselves a tell,
so variety wins over any cap outside Precise.

### 3. Em dashes and en dashes
humanizer bans them from the final text. no-ai-slop allows none in short copy and
one or two in long drafts. STE100 does not ban them but treats one as a sign the
sentence should split.

**Ruling:** default to zero. Replace each with a period, comma, colon, or
parentheses, or rewrite the sentence. Two exceptions: (a) the writer's own sample
uses them, in which case match the sample's rate; (b) Voice register long-form
where the dash clearly beats every alternative, capped at roughly one per thousand
words. Never in Plain short copy and never in Precise. Also catch spaced dashes
(` — `) and double hyphens (` -- `) used as dashes. Try splitting the sentence
before you reach for a dash.

### 4. Semicolons
STE100 bans the mark outright. The other two are silent.

**Ruling:** banned in Precise. Allowed but rare in Voice and Plain, at most one
per five hundred words. A semicolon joining two independent clauses that would
read fine as two sentences is a split waiting to happen.

### 5. Bullets and numbered lists
See [Lists are allowed](#lists-are-allowed). This is the one ruling that overrides
all three sources rather than reconciling them.

### 6. Hedging versus modality
humanizer cuts excessive qualifiers. no-ai-slop cuts empty qualifiers but keeps
real uncertainty. STE100 says never weaken a hedge, because confidence is content.

**Ruling:** delete stacked and duplicate hedges. Keep exactly one hedge, the one
that states the writer's actual confidence. "It could potentially possibly be
argued that the policy might have some effect" becomes "the policy may affect
outcomes," not "the policy affects outcomes." When the simple-tense rule and the
modality rule collide, **modality wins**: keep "may have failed" over "failed."
Also cut caveats that exist only to repair an earlier overstatement; fix the
overstatement instead.

### 7. Groups of three
humanizer flags forced triples. STE100 wants lists for three or more items.

**Ruling:** three real things are three real things. Keep them, or make them a
list. Flag only the forced triple: three abstract nouns standing in for one idea
("innovation, inspiration, and industry insights"), or triples repeating across
consecutive paragraphs. Count the things before you cut the pattern.

### 8. Hyphenated word pairs
humanizer says drop the hyphen from common pairs, giving "high quality report."

**Ruling: rejected.** This one upstream rule is wrong, and it fights STE100
directly by manufacturing the ambiguity STE exists to remove. Keep the hyphen
wherever grammar needs it, which means in a compound modifier before a noun, in
every register: "a high-quality report," "a data-driven decision." Drop it after
the noun, where grammar drops it anyway: "the report is high quality." What is
actually worth fixing is the *cliché stack*, not the punctuation. A sentence
carrying "cross-functional," "data-driven," and "client-facing" has a content
problem no hyphen change will solve.

### 9. Curly quotes
humanizer says convert to straight quotes.

**Ruling:** match the destination. Straight quotes in code, CLI output, plain
text, Markdown source, YAML, and JSON. Curly quotes are correct in typeset prose
and are what Word, Google Docs, macOS, and most publishing systems produce by
themselves. The real tell is *mixed* usage inside one document. Never treat curly
quotes on their own as evidence of AI authorship.

### 10. Heading case
humanizer wants sentence case.

**Ruling:** sentence case by default. Follow the destination's house style when it
has one. Above all, be internally consistent: mixed casing across headings in one
document is the actual tell.

### 11. Output format
All three sources return something different: humanizer prints draft, then audit,
then final; no-ai-slop prints the edit plus What changed; STE100 prints the
rewritten text and nothing else.

**Ruling:** see [Output contract](#output-contract). The draft, the self-audit, and
the eval pass are always **internal**. Never print an intermediate draft unless
the user asks to see the working.

### 12. Passive voice
All three prefer active. STE100 alone carves out an exception.

**Ruling:** active voice by default, with a human or named subject. Keep the
passive when the actor is genuinely unknown, genuinely irrelevant, or deliberately
de-emphasized. In Precise, procedures and instructions are always active; passive
is allowed only in descriptive text.

### 13. Repeated words versus synonym cycling
All three agree that rotating synonyms for one thing is a fault. They differ on
how far to go.

**Ruling:** one name per thing. In Precise this is absolute, including one part of
speech per word where both readings work. In Voice and Plain, fix the repeated
*sentence pattern*, not the repeated *word*: the fix for three sentences opening
with "She" is to merge or restructure them, not to invent a synonym for "She."

### 14. Bold text
humanizer flags mechanical bolding. no-ai-slop flags decorative mid-sentence bold.

**Ruling:** bold marks real structure, which means labels, table headers, defined
terms, and genuine warnings. It never marks emphasis inside a sentence. If a
sentence needs emphasis, rewrite it so the important word lands last.

### 15. Present perfect tense
STE100 excludes it. The others are silent.

**Ruling:** keep it wherever it carries current relevance that the simple past
does not. "The job has completed" (and its output is available now) is not "the
job completed" (at some past point). The exclusion applies to Precise procedures
only, and even there meaning beats tense.

## Lists are allowed

**A bulleted or numbered list is not an AI tell, and this skill does not treat it
as one.** Where the source skills counsel against lists, that counsel is
overridden. Use a list freely, and without apology, whenever the content is
genuinely a list:

1. A sequence of three or more steps the reader will follow in order. Number it.
2. Parallel options, requirements, cases, or trade-offs the reader will scan and
   compare rather than read straight through.
3. Reference material meant for lookup: flags, config keys, error codes, field
   definitions, checklists, acceptance criteria.
4. Anything where prose would force the reader to hold five items in their head
   at once.

Tables are equally fine, on the same test.

What stays slop is *decorative* listing, and only these shapes:

- **Bold mini-heading bullets** where each item is `**Label:** a sentence that
  restates the label.` Keep the label or keep the sentence, not both.
- Two sentences of prose broken into two bullets for the look of it.
- One continuous argument chopped into fragments for visual rhythm.
- A list of one item.
- Emoji used as bullet markers.

The test: does the reader gain scanning or ordering from the list shape? Then keep
the list. Is the list there to look organized? Then write the prose.

## Workflow

1. **Read the whole thing first.** Do not start editing mid-draft.
2. **Set the register and the mode.** Keep both internal unless asked.
3. **Note three to five voice signals to protect**: vocabulary, cadence,
   bluntness, humor, admitted uncertainty, digressions, level of polish. Keep this
   note internal.
4. **Scan** against `references/ai-tells.md` (all registers) and
   `references/clarity-rules.md` (Plain and Precise). Read both files before your
   first edit unless you have already read them this session.
5. **Check false positives** before cutting anything. `references/ai-tells.md` ends
   with the list of things that look like tells and are not. A pattern inside a
   quotation, a title, a proper name, or an example being discussed is exempt.
6. **Audit mode stops here.** Return the findings and offer to edit.
7. **Rewrite** with the minimum effective edit. Fix the tells, the tangles, and the
   repetition. Leave strong human sentences alone. Restructure a paragraph around
   its point rather than patching one flagged phrase at a time. If a rewrite would
   drop a safety condition, a scope qualifier, or a number, keep the longer
   phrasing.
8. **Self-audit, internally.** Ask two questions and answer them honestly:
   - What in this still reads as machine-written?
   - Did I add or lose any fact, name, number, date, quote, citation, or claim?
     Any addition or loss is an error, not a stylistic choice.
9. **Run the eval.** Check the result against `checks/eval.md`, every item, pass or
   fail. Fix each failure and run it again. Optionally run `scripts/tellscan.sh` on
   the text for the mechanical tells.
10. **Return** per the output contract. If the input was already clean, say so
    rather than forcing changes onto it.

## Output contract

| Input | What you return |
|---|---|
| Pasted draft, Edit mode | The final text, then **What changed** in at most six short lines |
| Named file | Write only the final text to the file. Change prose only: leave code blocks, YAML frontmatter, data, and link targets untouched. Then summarize in chat. |
| Clarify mode, or a short string such as an error message or tool description | The final text alone. No preamble, no mode announcement, no violation count, no closing offer. |
| Embedded (another task or skill calls this one for a commit message, PR body, email, or document) | The final text alone. |
| Audit mode | Findings only: pattern, quoted line, short fix. No rewrite, no score. |

One permitted addition in Clarify mode: if you deliberately kept a longer or
hedged phrasing, add a single line after the text starting `Kept as-is:`, naming
the phrase and the precision that would have been lost. Omit the line when there
is nothing to report.

## Boundaries

**This skill will:**

- Remove machine fingerprints while keeping the writer's meaning and voice.
- Preserve every fact, condition, hedge, and scope qualifier in the source.
- Name the patterns it found when asked, with the offending line quoted.
- Say when a draft is already clean.
- Say when the problem is the content rather than the prose.

**This skill will not:**

- Invent a fact, source, number, cause, or frequency to make a sentence land.
- Manufacture opinions, feelings, or confessions on the writer's behalf.
- Claim that a text was AI-written. It names patterns; it does not accuse.
- Promise a result against any AI-detection tool. Detectors are unreliable in both
  directions, and no rewrite can be certified against them. What this skill
  delivers is text with no known tells and no fabricated content.
- Reproduce ASD's approved ~900-word dictionary. STE compliance beyond the
  structural rules needs the real standard; see `references/clarity-rules.md`.
- Certify aerospace-grade STE. This is a clarity tool built on STE's discipline,
  not a certified STE authoring tool.
- Make weak content strong. Form is all a rewrite can fix. A hollow paragraph
  rewritten under these rules becomes a clean, short, well-punctuated hollow
  paragraph. Say that instead of polishing it.
- Compress past the point of clarity. Fewer words is not the goal. No misreadings
  is the goal.

## Files

| File | Read it when |
|---|---|
| `references/ai-tells.md` | Every Edit and Audit. The full merged pattern catalog, plus the false-positive list and the human details to keep. |
| `references/clarity-rules.md` | Plain and Precise registers. STE structural and lexical rules, scoped by register. |
| `references/conflict-log.md` | You need the provenance of a ruling, or you are updating this skill against a new upstream version. |
| `checks/eval.md` | Before returning any Edit. Every item, pass or fail. |
| `examples/before-after.md` | You want a worked example in the register you are editing. |
| `scripts/tellscan.sh` | You want the mechanical tells (dashes, curly quotes, emoji, stock phrases) found by grep rather than by eye. |

## Credits

Merged from three MIT-licensed skills: [no-ai-slop](https://github.com/petergyang/no-ai-slop)
by Peter Yang, [humanizer](https://github.com/blader/humanizer) by Siqi Chen, and
[asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill) by Danyu Chn. The
pattern catalog derives from
[Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing),
maintained by WikiProject AI Cleanup. The clarity rules paraphrase the rule
categories of ASD-STE100 Issue 9 (January 2025) without reproducing the standard.
