# Conflict log

The receipt for [Conflict rulings](../SKILL.md#conflict-rulings). Read this when you
need the provenance of a ruling, when you are updating this skill against a newer
upstream version, or when a user asks why the merged skill departs from one of its
sources.

The rulings in `SKILL.md` are what you follow. This file records what each source
actually said, which upstream line lost, and why.

## Source versions merged

| Source | Version merged | Notes |
|---|---|---|
| [petergyang/no-ai-slop](https://github.com/petergyang/no-ai-slop) | `skills/no-ai-slop/SKILL.md` + `eval.md`, main branch as of 2026-09-01 | Includes the portability test, show-don't-tell, and interpretive-metadiscourse additions that postdate the copy previously installed locally |
| [blader/humanizer](https://github.com/blader/humanizer) | 2.11.2 | Supersedes the 2.8.0 copy installed locally as `humanize-text`. 2.11.2 adds tells 30 to 35, the false-positive list, the human-details list, and the mode-based output contract |
| [danyuchn/asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill) | 0.4.0 | Rule categories of ASD-STE100 Issue 9, January 2025. Dictionary deliberately not reproduced |

All three are MIT licensed.

## Deduplication map

Sixteen patterns appeared in both no-ai-slop and humanizer under different names.
Each survives once in [ai-tells.md](ai-tells.md), under the number shown.

| no-ai-slop name | humanizer name | Merged as |
|---|---|---|
| Importance puffery | 1. Inflated claims about importance | Tell 1 |
| Words to cut (promotional half) | 4. Sales language | Tell 2 |
| Superficial analysis | 3. Shallow analysis with -ing phrases | Tell 4 |
| Weasel attribution | 5. Vague sources | Tell 8 |
| Binary contrasts + Negative listing | 9. Not X but Y | Tell 11 |
| Synonym cycling | 11. Changing names, repeated openings | Tell 14 |
| Robotic rhythm | (implicit) | Tell 15 |
| Dramatic fragmentation | 31. Forced punchlines | Tell 16 |
| Words to cut (banned-word half) | 7. Overused AI words | Tell 18 |
| Fake-strong verbs | 8. Avoiding is and are | Tell 19 |
| Formatting slop (bold half) | 15. Too much bold | Tell 25 |
| Formatting slop (bullets half) | 16. Lists with bold mini-headings | Tell 26 |
| Formatting slop (emoji half) | 18. Emojis | Tell 27 |
| Formatting slop (headers half) | 29. Heading repeated in first sentence | Tell 28 |
| Throat-clearing openers | 28. Announcing the next point + 33. Fake-candid openings | Tell 31 |
| Faux-insight setups + Rhetorical setups | 27. Pretending to reveal a deeper truth | Tell 32 |
| Fake-profound kickers | 32. Formulaic sayings | Tell 34 |
| Summary-recap endings | 25. Generic positive endings | Tell 38 |
| Em dashes | 14. Em and en dashes | Tell 24 + ruling 3 |
| Often-empty phrases | 23. Filler phrases | Tell 36 |
| Often-empty adverbs | 24. Too many qualifiers | Tell 36 + tell 37 |

Unique to no-ai-slop and carried through: the portability test (tell 5),
show-don't-tell (tell 6), colon reveals (tell 12), interpretive metadiscourse
(tell 33), the minimum-effective-edit principle (SKILL.md workflow step 7), and the
detect-without-rewriting mode (Audit).

Unique to humanizer and carried through: name-dropping (tell 3), formulaic
challenges sections (tell 7), knowledge-cutoff and gap-fill (tell 9), false ranges
(tell 10), writing about the previous version (tell 17), chatbot residue (tell 30),
unraised objections and fake alternatives (tell 35), the false-positive list, the
human-details list, and voice calibration from a writing sample.

Unique to asd-ste100 and carried through: everything in
[clarity-rules.md](clarity-rules.md), plus the modality law, which became
[law 2](../SKILL.md#the-four-laws).

## The fifteen conflicts, with sources

### 1. Personality versus flatness
- **humanizer** §"Add personality only when it fits": use personality in blog posts
  and essays, keep reference and technical text neutral. Earlier versions (2.8.0 and
  before) were stronger: "Add soul", "Have opinions", "Let some mess in".
- **no-ai-slop** "Editing principles": preserve the writer's real voice, "Don't
  invent claims, examples, stats, or opinions."
- **asd-ste100** "Boundaries": will not simplify creative or persuasive copy; STE is
  "deliberately flat and literal".
- **Ruling:** register decides how much, law 3 decides whose. no-ai-slop's
  non-invention constraint wins globally, so humanizer's "add soul" is narrowed from
  *supply* to *surface*, and scoped to Voice register. **Loser:** humanizer's
  unscoped "inject actual personality".

### 2. Sentence length
- **humanizer** tell 11 and the human-details list: keep variety in sentence length;
  an even mid-length cadence is itself the tell.
- **no-ai-slop:** "Keep longer spoken sentences, fragments, and changes in pace when
  they are clear and characteristic of the writer."
- **asd-ste100:** hard caps of 20 and 25 words.
- **Ruling:** caps are hard in Precise and diagnostic elsewhere. **Loser:** the
  universal cap. Applying it to prose produces exactly the uniform cadence the other
  two sources identify as a tell, so it cannot be global.

### 3. Em dashes and en dashes
- **humanizer** §14: "The final rewrite must not contain em dashes or en dashes,
  unless the writer's sample uses them." Its own false-positive list then says em
  dashes alone are not evidence, since editors and journalists use them heavily.
- **no-ai-slop:** none in short copy, one or two in longer drafts when they clearly
  beat commas, periods, or parentheses.
- **asd-ste100:** Rule 8.1 bans the semicolon and explicitly permits every other
  mark, em dash included, while noting a dash often signals a sentence that should
  split.
- **Ruling:** default zero, with the sample exception from humanizer and a narrow
  Voice-long-form allowance from no-ai-slop, capped at about one per thousand words.
  **Loser:** the absolute ban, which humanizer itself contradicts two sections later.

### 4. Semicolons
- **asd-ste100:** Rule 8.1, banned outright.
- **Others:** silent.
- **Ruling:** banned in Precise, rare elsewhere. No real conflict, only a scope
  question.

### 5. Bullets and numbered lists
- **no-ai-slop** "Formatting slop": "bullet lists where two sentences of prose would
  read better".
- **humanizer** §16: converts a three-item list to a prose sentence.
- **asd-ste100** paragraph rules: "Use vertical (numbered or bulleted) lists for
  sequences, conditions, or complex enumerations instead of burying them in prose."
- **Ruling:** [Lists are allowed](../SKILL.md#lists-are-allowed). Lists are never a
  tell on their own; only five specific decorative shapes stay banned. **Loser:** the
  general suspicion of lists in both writing skills. This is the one ruling that
  overrides all three sources rather than reconciling them, and it is a deliberate
  operator decision, not an inference from the sources.

### 6. Hedging versus modality
- **humanizer** §24: cut piled-up qualifiers.
- **no-ai-slop:** cut empty qualifiers, keep "I think", "maybe", "to be honest" when
  they express real uncertainty.
- **asd-ste100** step 4 and Example B: "A shorter sentence that upgrades a hedge to a
  fact is not a simplification, it is a different claim." Its own history is the
  evidence: an earlier draft of its examples file rewrote "an error may have
  occurred" to "the request failed", and had to be corrected.
- **Ruling:** delete duplicates, keep the one real hedge, never promote to certainty,
  and modality beats tense. **Loser:** any reading of humanizer §24 that cuts the
  last hedge.

### 7. Groups of three
- **humanizer** §10: AI forces ideas into threes.
- **asd-ste100:** use a list for three or more items.
- **Ruling:** count the things first. Three real things are fine and may deserve a
  list. Only forced abstract triples are the tell. **Loser:** a blanket
  three-is-suspicious heuristic.

### 8. Hyphenated word pairs
- **humanizer** §26 (2.8.0): de-hyphenate common pairs, producing "the cross
  functional team delivered a high quality, data driven report". 2.11.2 softened this
  to keep the hyphen before a noun and drop it after.
- **asd-ste100:** ambiguity is the enemy; do not drop words or marks to shorten.
- **Ruling: rejected.** Keep the hyphen wherever grammar needs it, in every register.
  The 2.8.0 form manufactures exactly the ambiguity STE exists to remove, and the
  real fault is the cliché stack, not the punctuation. **This is the only place where
  this skill declares an upstream rule wrong rather than out of scope.** Recorded as
  [tell 23](ai-tells.md#23-the-cliche-stack).

### 9. Curly quotes
- **humanizer** §19: convert curly to straight. Its own false-positive list then
  notes that macOS, Word, Google Docs, and most content systems curl automatically.
- **Others:** silent.
- **Ruling:** match the destination; the tell is mixed usage. **Loser:** the blanket
  conversion, again contradicted by humanizer's own false-positive list.

### 10. Heading case
- **humanizer** §17: sentence case.
- **Others:** silent.
- **Ruling:** sentence case by default, house style when one exists, internal
  consistency above both. No real conflict.

### 11. Output format
- **humanizer** "How to return the result": pasted text returns draft, then remaining
  patterns, then final. File mode writes only final text. Embedded mode returns only
  final text.
- **no-ai-slop** workflow step 6: full edited draft plus a What changed section.
- **asd-ste100** "Output Format": the rewritten text and nothing else, with no
  preamble, no mode announcement, no violation count, no summary.
- **Ruling:** one table keyed to input type, in
  [Output contract](../SKILL.md#output-contract). The draft and the audit are always
  internal. **Loser:** humanizer's printed intermediate draft, which conflicts
  directly with STE's clean-output requirement and is unwanted in every embedded use.

### 12. Passive voice
- All three prefer active. **asd-ste100** alone carves out the exception: passive is
  allowed in descriptive text when the actor is genuinely unknown or irrelevant.
- **Ruling:** active by default with that exception, tightened in Precise where
  procedures are always active. Compatible, not conflicting.

### 13. Repeated words versus synonym cycling
- **humanizer** §11: fix the repeated *pattern*, not the repeated *word*. "The
  remaining sentence may still start with She."
- **no-ai-slop:** "If the clear word is right, repeat it."
- **asd-ste100:** one word, one meaning, enforced against a dictionary.
- **Ruling:** one name per thing, absolute in Precise, pattern-level elsewhere. All
  three agree on direction; only the strictness differs.

### 14. Bold text
- **humanizer** §15: mechanical bolding is a tell.
- **no-ai-slop:** "bold sprinkled mid-sentence for emphasis" is slop.
- **asd-ste100:** silent, but uses bold labels in tables throughout.
- **Ruling:** bold marks structure, never mid-sentence emphasis. Compatible.

### 15. Present perfect
- **asd-ste100:** excluded, with the skill's own carve-out already written in: keep
  the compound form where it carries current relevance, and flag the departure.
- **Others:** silent.
- **Ruling:** keep it where meaning requires; the exclusion applies to Precise
  procedures only. This ruling adopts the source's own exception and makes it the
  default.

## Instructions dropped entirely

Three upstream instructions are not carried into this skill.

1. **humanizer's "final anti-AI pass" printed as output.** The two closing questions
   survive as an internal step ([eval.md](../checks/eval.md#the-two-closing-questions)).
   Printing the interrogation transcript conflicts with every output mode except
   pasted-draft, and it reads as theatre.
2. **humanizer §26's de-hyphenation examples.** See conflict 8.
3. **asd-ste100's mode announcement.** Its own Output Format section already
   suppresses this. The register choice stays internal here for the same reason.

## Updating this skill

When a source publishes a new version:

1. Diff the new source against the version recorded in
   [Source versions merged](#source-versions-merged).
2. For each changed rule, check this file for an existing ruling that covers it. If
   one exists, decide whether the change alters the reasoning, and update the ruling
   rather than appending a second rule that contradicts the first.
3. New patterns with no conflict go straight into [ai-tells.md](ai-tells.md) with the
   next number, and get an eval item in section 4 of
   [eval.md](../checks/eval.md).
4. Update the version table and the dedupe map here.

The one thing not to do is append the new source text wholesale. That is how the
three sources came to contradict each other in the first place.
