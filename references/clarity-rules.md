# Clarity rules: ASD-STE100, scoped by register

Adapted from [danyuchn/asd-ste100-skill](https://github.com/danyuchn/asd-ste100-skill),
which encodes the rule categories of ASD-STE100 Issue 9 (January 2025). Read this
file when editing in **Plain** or **Precise** register. In **Voice** register these
rules are advisory at most, and several of them would flatten writing that is
supposed to have a pulse.

## What ASD-STE100 is, and what this file is not

ASD-STE100 (Simplified Technical English) is a controlled language published by ASD,
the AeroSpace and Defense Industries Association of Europe. Airlines staffed largely
by non-native English speakers asked for maintenance documentation that could not be
misread, because a misread instruction on an aircraft kills people. It was first
released in 1986 as AECMA Document PSC-85-16598, is maintained by the Simplified
Technical English Maintenance Group, and has been free to download since Issue 6
(2013).

The standard has two halves:

1. **53 writing rules across 9 sections** covering word choice, grammar, sentence
   structure, and style.
2. **A dictionary** of roughly 900 approved words, each restricted to one meaning
   and one part of speech, plus roughly 1,200 words to avoid with suggested
   replacements. Organizations may add their own approved technical terms on top.

**This file paraphrases the rule categories. It does not reproduce the dictionary,
and it does not reproduce the standard's text.** ASD-STE100 is free to obtain but not
free to redistribute: Issue 9 page 2 restricts reproduction to eight listed
categories of organization, none of which covers this skill. When exact approved
wording matters, such as real aircraft maintenance documentation, request the
standard from the [official downloads page](https://www.asd-ste100.org/STE_downloads.html)
and check word by word against the real dictionary.

## Why this belongs in a humanizing skill

STE was built for a reader who cannot ask a follow-up question: a technician on a
tarmac with a manual and no author to call. An agent parsing another agent's output,
a user reading an error string, or a translator handling a tool description is in the
same position. The discipline that stops a technician misreading a torque spec is the
same discipline that stops a downstream system misreading an instruction.

It also does something the AI-tell catalog cannot. The catalog removes fingerprints.
These rules remove *ambiguity*, and ambiguous prose reads as machine-written even
when every stock phrase is gone.

## Structural rules

**These are self-contained: you can apply them from the description alone.** Mandatory
in Precise. Apply them in Plain unless doing so damages the writing. Advisory in
Voice.

| Rule | Do | Do not |
|---|---|---|
| Active voice | "The agent deletes the file." | "The file is deleted." Unless the actor is genuinely unknown, irrelevant, or deliberately de-emphasized. |
| <a id="no-phrasal-verbs"></a>No phrasal verbs (Rule 9.3) | "Remove the panel." "Start the job." | "Take off the panel." "Spin up the job." A two-word verb has meanings the parts do not predict. |
| One instruction per sentence | "Open the file. Read line 3." | "Open the file and read line 3, then check whether it matches." |
| Sentence length | 20 words maximum for instructions and procedures. 25 for descriptions. | Long chains of compound and subordinate clauses. |
| No semicolons (Rule 8.1) | Write separate sentences. | Any semicolon. STE bans the mark outright, not only as a clause join. Every other standard mark is permitted, including the em dash, though this skill has [its own stricter dash rule](../SKILL.md#3-em-dashes-and-en-dashes). |
| Noun clusters | 3 words maximum stacked as a noun phrase: "fuel pump valve". | "high pressure fuel pump inlet valve assembly". Break it with a relative clause. |
| No ellipsis | Keep the subject, the verb, and the article explicit even if it reads longer. | Drop words to save space. "Files not backed up will be lost" hides which files. |
| Paragraph limits | One topic per paragraph, 6 sentences maximum. | Multi-topic paragraphs. |
| Lists for sequences | Use a numbered or bulleted list for 3 or more steps or conditions. | Bury a sequence inside one prose sentence. |
| Safety text first | Open a safety-critical instruction with the command or the condition. | Bury the condition mid-sentence. |

### Sentence-length caps outside Precise

In Voice and Plain the caps are a **diagnostic, not a limit**. A sentence over 25
words gets read once: if it carries one idea clearly, keep it. If it carries three
unrelated ideas, split it. Never split a clear sentence to hit a number, and never
produce a document of uniformly capped sentences, because that uniformity is itself
an AI tell (see [tell 15](ai-tells.md#15-robotic-rhythm)).

## Lexical rules

**These are defined by the official dictionary, which this skill does not have.**
Without it they degrade from a checkable standard into a preference for plain words.
Apply them as a direction of travel, and never claim dictionary compliance you cannot
verify.

| Rule | Do | Why it is weaker here |
|---|---|---|
| One word, one meaning | Pick one verb per action and reuse it every time. Always "check", never rotating check / verify / confirm for the same action. | Consistency inside a document is checkable. Which word ASD approved is not. |
| One part of speech per word | "Apply oil to the valve" (oil as a noun) over "Oil the valve" (oil as a verb), when both read equally well. | Whether "oil" is approved as a noun only is a dictionary fact. |
| <a id="verbs-not-nouns"></a>Verbs, not nouns (Rule 3.7) | "Analyze the log." | Preferring the verb form is safe anywhere. Knowing which verb is *approved* needs the dictionary. |
| Domain terms | Keep necessary technical nouns and verbs, and define each once if it is not common English. STE explicitly allows a project glossary on top of its base dictionary. | The glossary allowance is real STE. The base dictionary it extends is absent. |

In Precise register, treat "one word, one meaning" as a hard rule for the document
you are editing. In Voice and Plain, apply
[ruling 13](../SKILL.md#13-repeated-words-versus-synonym-cycling): fix the repeated
sentence pattern, not the repeated word.

## Verb forms and tense

STE permits the infinitive, the imperative, simple present, simple past, simple
future, and the past participle used only as an adjective. It excludes present
perfect and other compound forms: "we received the report", not "we have received
the report". The "-ing" form is permitted only as a technical noun, never as a verb
form.

**One exception, and it matters.** Aircraft manuals never need the present perfect,
so the exclusion costs the standard nothing. Other text is not so lucky. "The job has
completed" (and its output is available now) and "the job completed" (at some past
point) are different statements, and status text frequently needs the first.

**Where a compound form carries information the simple form cannot, keep it.** That
covers current relevance and it covers hedges: "may have failed" keeps its auxiliary.
When the tense rule and the modality rule collide, **modality wins**. See
[ruling 15](../SKILL.md#15-present-perfect-tense).

## The six mechanical habits

These cover most of what makes machine-written English hard to parse. Each is
mechanical: you can point at the exact word or mark that breaks it, with no judgment
call. Scan for all six before rewriting anything.

1. **Synonym rotation.** One thing gets several names in one document: the user, the
   customer, the client. The reader cannot tell whether that is one thing or three.
   Fix: pick one name and use it every time.
2. **Hedge stacking.** Qualifiers pile up until the sentence asserts nothing: "it is
   important to note that this may potentially help to improve". Fix: state the claim
   at its real confidence, or delete it. Keep the last real hedge.
3. **Nominalization.** An action frozen into a noun: "perform an analysis of",
   "provides assistance to". Fix: use the verb.
4. **Marketing adjectives.** Words claiming quality instead of showing it: seamless,
   robust, powerful, cutting-edge, effortless, blazing-fast. Fix: delete, or replace
   with the measurement that earns the claim.
5. **Run-on sentences.** Several ideas joined by semicolons or dashes. Fix: one idea
   per sentence.
6. **Soft phrasal verbs.** Spin up, reach out, dive into, kick off. Fix: the single
   plain verb.

## Modality: the rule that outranks every other rule here

Hedges carry the author's confidence, and **confidence is content**. A shorter
sentence that upgrades a hedge to a fact is not a simplification. It is a different
claim, and it is the most common way a well-meaning clarity rewrite goes wrong,
because hedges are exactly what a length cap tempts you to cut.

- "The request may have failed" never becomes "the request failed".
- "This could be caused by X" never becomes "X is the cause".
- "Sometimes the client retries" never becomes "the client retries".

And the mirror of the same law: never *add* certainty either. A rewrite that reads
better because you supplied a cause, a frequency, or a mechanism has stopped being a
rewrite. See [law 1](../SKILL.md#the-four-laws).

## What a clarity rewrite cannot fix

STE fixes the form of a text, not its substance. A hollow paragraph rewritten under
these rules becomes a clean, short, well-punctuated hollow paragraph. If the text has
nothing to say, say that instead of polishing it.

And stop at unambiguous, not at shortest. Cutting words is not the goal. Past a
certain point compression costs the reader time rather than saving it.

## Sources

- [ASD-STE100 official site](https://www.asd-ste100.org/)
- [ASD-STE100: About STE](https://www.asd-ste100.org/about_STE.html)
- [ASD Europe: Simplified Technical English](https://www.asd-europe.org/standards-specifications/simplified-technical-english/)
- [Simplified Technical English on Wikipedia](https://en.wikipedia.org/wiki/Simplified_Technical_English)
- [TechScribe: ASD-STE100 Simplified Technical English](https://www.techscribe.co.uk/techw/asd-simplified-technical-english.htm)
- [SKYbrary: Simplified Technical English](https://skybrary.aero/articles/simplified-technical-english-ste)
