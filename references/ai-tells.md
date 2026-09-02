# AI tells: the merged catalog

Every pattern from [no-ai-slop](https://github.com/petergyang/no-ai-slop) and
[humanizer](https://github.com/blader/humanizer), deduplicated into one list, with
the [conflict rulings](../SKILL.md#conflict-rulings) already applied. Where the two
sources named the same fault differently, it appears once here.

Read the whole file before your first edit in a session. Then read
[What is not a tell](#what-is-not-a-tell) before you cut anything, because roughly
a third of these patterns have an innocent twin.

**Register note.** Tells 1 through 30 and 36 through 38 apply in every register.
Tells 31 through 35 are about performed personality, so they apply in Voice and Plain
and are moot in Precise, where there is no personality to perform.

---

## A. Inflation and puffery

### 1. Inflated claims about importance and legacy

**Watch for:** stands as, serves as, is a testament to, is a reminder that, plays a
vital / significant / crucial / pivotal / key role, marks a pivotal moment,
underscores its importance, highlights its significance, reflects a broader,
symbolizing its ongoing / enduring / lasting, contributing to the, setting the
stage for, marking a shift, represents a shift, key turning point, evolving
landscape, focal point, indelible mark, deeply rooted, solidifies its position.

Ordinary details get described as marking a major change or proving a legacy. State
the fact and let the reader decide whether it matters.

**Before:** The Statistical Institute of Catalonia was officially established in
1989, marking a pivotal moment in the evolution of regional statistics in Spain.
This initiative was part of a broader movement across Spain to decentralize
administrative functions and enhance regional governance.

**After:** The Statistical Institute of Catalonia was established in 1989, part of
a wider decentralization of administrative functions in Spain.

**Before:** The launch marks a pivotal moment for the company.

**After:** The launch is the company's first paid product.

### 2. Sales language

**Watch for:** boasts a, vibrant, rich (figurative), profound, enhancing its,
showcasing, exemplifies, commitment to, natural beauty, nestled, in the heart of,
groundbreaking (figurative), renowned, breathtaking, must-visit, stunning,
seamless, robust, powerful, cutting-edge, effortless, blazing-fast, world-class,
best-in-class, next-generation.

Adjectives that claim quality instead of showing it. Delete, or replace with the
measurement that earns the claim.

**Before:** Nestled within the breathtaking region of Gonder in Ethiopia, Alamata
Raya Kobo stands as a vibrant town with a rich cultural heritage and stunning
natural beauty.

**After:** Alamata Raya Kobo is a town in the Gonder region of Ethiopia.

### 3. Name-dropping to prove importance

**Watch for:** independent coverage, local / regional / national media outlets,
written by a leading expert, active social media presence, trusted by, as featured in.

A list of famous publications or a follower count offered as proof that something
matters, with no context for what was said or done.

**Before:** Her views have been cited in The New York Times, BBC, Financial Times,
and The Hindu. She maintains an active social media presence with over 500,000
followers.

**After:** Her views have been cited in The New York Times and the BBC.

Keep a citation that says what the person argued and where. Do not invent that
context to justify keeping the list.

### 4. Shallow analysis with -ing phrases

**Watch for:** highlighting, underscoring, emphasizing, ensuring, reflecting,
symbolizing, contributing to, cultivating, fostering, encompassing, showcasing,
demonstrating, signaling, cementing, all as a trailing clause.

A participle phrase bolted onto a fact to make it sound deeper. Either say what
actually follows from the fact, or end the sentence.

**Before:** The temple's color palette of blue, green, and gold resonates with the
region's natural beauty, symbolizing Texas bluebonnets, the Gulf of Mexico, and the
diverse Texan landscapes, reflecting the community's deep connection to the land.

**After:** The temple is painted blue, green, and gold, colors meant to evoke Texas
bluebonnets and the Gulf of Mexico.

**Before:** The launch adds file search, highlighting the team's commitment to
better workflows.

**After:** The launch adds file search, so users can find old drafts without
leaving the editor.

### 5. The portability test

If a sentence could move unchanged to another person, company, country, or product
and still read as true, it is filler. Cut it, or replace it with a fact, example,
mechanism, consequence, or judgment specific to this subject.

**Before:** The integration improved efficiency and streamlined the team's
workflow.

**After:** The integration cut deploy time from 40 minutes to 4.

Apply this before any other cut. It catches slop the named patterns miss.

### 6. Show, do not tell the reader what to think

Let facts, actions, examples, and consequences carry the emphasis. Cut commentary
that labels a point important, surprising, subtle, or obvious instead of
demonstrating it. If the surrounding prose already shows the point, delete the
commentary and trust the reader.

### 7. Formulaic challenges and outlook sections

**Watch for:** Despite its ... faces several challenges, Despite these challenges,
Challenges and Legacy, Future Outlook, Looking ahead.

A stock section about challenges, future prospects, or continued growth that
repeats vague claims instead of adding facts.

**Before:** Despite its industrial prosperity, Korattur faces challenges typical of
urban areas, including traffic congestion and water scarcity. Despite these
challenges, with its strategic location and ongoing initiatives, Korattur continues
to thrive as an integral part of Chennai's growth.

**After:** Korattur has recurring traffic congestion and water shortages.

Add a date or a public action only if the source provides it.

---

## B. Vagueness and unsupported claims

### 8. Vague sources and weasel attribution

**Watch for:** industry reports, observers have cited, experts agree, experts
argue, some critics argue, many argue, widely regarded as, studies show, research
suggests, several sources or publications when few are named, it is believed that.

**Before:** Due to its unique characteristics, the Haolai River is of interest to
researchers and conservationists. Experts believe it plays a crucial role in the
regional ecosystem.

**After:** Researchers and conservationists study the Haolai River for its unusual
characteristics.

Name the real source when the text supplies one. Otherwise remove the claim, or
ask the user for the source. Never invent one, and never launder a guess into a
citation.

### 9. Knowledge-limit disclaimers and speculative gap-fill

**Watch for:** as of my last update, up to my last training update, while specific
details are limited, based on available information, not publicly available,
maintains a low profile, keeps personal details private, prefers to stay out of the
spotlight, likely grew up, likely studied, it appears to have been.

Two faults, usually together: the model announces that it could not find a source,
then fills the gap with a plausible guess.

**Before:** While specific details about the company's founding are not extensively
documented in readily available sources, it appears to have been established
sometime in the 1990s.

**After:** The company's founding date is not documented in the available sources.
Or cut the sentence. State a date only if a source provides one.

**Before:** Information about her early life is not publicly available, suggesting
she maintains a low profile and keeps personal details private. She likely grew up
in a middle-class household, which shaped her later interest in education reform.

**After:** Her early life is not documented in the available sources. Or omit the
section.

### 10. False from-X-to-Y ranges

A "from X to Y" construction where X and Y do not sit on any real scale.

**Before:** Our journey through the universe has taken us from the singularity of
the Big Bang to the grand cosmic web, from the birth and death of stars to the
enigmatic dance of dark matter.

**After:** The book covers the Big Bang, star formation, and current theories about
dark matter.

---

## C. Structure and rhythm

### 11. Not-X-but-Y, binary contrasts, and negative listing

**Watch for:** This is not X, it's Y. The question isn't X, it's Y. It's not just X
but Y. Not only ... but also. Not a X. Not a Y. A Z.

State Y directly. If the contrast carries real information, write it as a
comparison with both sides named.

**Before:** The question isn't the model. It's the eval.

**After:** The eval matters more than the model.

**Before:** It's not just about the beat riding under the vocals; it's part of the
aggression and atmosphere. It's not merely a song, it's a statement.

**After:** The heavy beat adds to the aggressive tone.

**Clipped tailing negation** is the same fault in miniature: "The options come from
the selected item, no guessing." Write the clause: "The options come from the
selected item, so the user does not have to guess."

### 12. Colon reveals

A noun phrase, a colon, then a lowercase dramatic payoff. "The detail that makes it
work: a separate agent grades it." "The best part: it learns."

Rewrite as a plain sentence. Colons are for lists, labels, and quotations, not for
manufactured suspense. Use sentence case after a colon unless grammar, a proper
noun, a title, or code requires otherwise.

**Before:** The detail that makes it work: a separate agent grades it.

**After:** A separate agent does the grading, which is what makes it work.

### 13. Forced groups of three

**Before:** The event features keynote sessions, panel discussions, and networking
opportunities. Attendees can expect innovation, inspiration, and industry insights.

**After:** The event includes talks and panels. There's also time for informal
networking between sessions.

Count the things first. Three real things are fine and may deserve a list
([lists are allowed](../SKILL.md#lists-are-allowed)). The tell is a triple of
abstract nouns standing in for one idea, or triples stacking across consecutive
paragraphs.

### 14. Synonym cycling and repeated sentence openings

AI handles repetition by rule instead of by ear. It renames the same thing, or it
starts several sentences with the same subject.

**Before (cycling):** The protagonist faces many challenges. The main character
must overcome obstacles. The central figure eventually triumphs. The hero returns
home.

**After:** The protagonist faces many challenges but eventually triumphs and
returns home.

**Before (repeated openings):** She noted the door. She noted the lock on it. She
filed both away.

**After:** She noted the door and its lock, then filed both away.

Do not ban the repeated word. Fix the repeated pattern. The surviving sentence may
still start with "She."

### 15. Robotic rhythm

Repeated sentence shapes, identically structured paragraphs, and an even
mid-length cadence throughout. Real writing alternates short and long without
trying to. Vary the shape only where it helps the point; do not impose a new
uniform rhythm on top of the old one.

### 16. Forced punchlines and dramatic fragmentation

**Watch for:** X. And Y. And Z. / That's it. That's the whole thing.

One short sentence can carry emphasis. A row of them feels staged.

**Before:** Then AlphaEvolve arrived. It had no preference for symmetry. No
aesthetic prior. No nostalgia for human taste. The old rules were gone.

**After:** AlphaEvolve changed the search because it did not favor symmetry or
human-looking designs. That made some of the older assumptions less useful.

### 17. Writing about the previous version

Documentation and code comments describe current behavior. Mention the old
behavior only in changelogs, release notes, and migration guides.

**Before:** This function was added to replace the previous approach of iterating
through all items, which caused O(n^2) performance.

**After:** This function uses a hash map for O(1) lookups, avoiding the O(n^2) cost
of naive iteration.

---

## D. Word level

### 18. Overused AI vocabulary

**High-frequency AI words:** actually, additionally, align with, crucial, delve,
elevate, embark, emphasizing, empower, enduring, enhance, ever-evolving,
facilitate, fostering, garner, harness, highlight (verb), interplay, intricate,
intricacies, key (adjective), landscape (abstract), leverage, meticulous,
multifaceted, paradigm shift, paramount, pivotal, quietly, realm, showcase,
streamline, supercharge, tapestry (abstract), testament, transformative,
underscore (verb), utilize, valuable, vibrant, beacon, game changer, this is huge,
this changes everything.

These are tells in aggregate, not one at a time. One "however" proves nothing;
four of this list in a paragraph is a signature. Preserve established technical
usage: "gate" and "gated" in a deployment context, "landscape" describing actual
terrain, "leverage" in finance.

**Before:** Additionally, a distinctive feature of Somali cuisine is the
incorporation of camel meat. An enduring testament to Italian colonial influence is
the widespread adoption of pasta in the local culinary landscape, showcasing how
these dishes have integrated into the traditional diet.

**After:** Somali cuisine also includes camel meat, which is considered a delicacy.
Pasta dishes, introduced during Italian colonization, remain common, especially in
the south.

### 19. Avoiding is, are, and has

**Watch for:** serves as, stands as, marks, represents, boasts, features, offers,
functions as, acts as, provides a.

**Before:** Gallery 825 serves as LAAA's exhibition space for contemporary art. The
gallery features four separate spaces and boasts over 3,000 square feet.

**After:** Gallery 825 is LAAA's exhibition space for contemporary art. The gallery
has four rooms totaling 3,000 square feet.

**Before:** The app serves as a centralized hub for sponsor management.

**After:** The app tracks sponsors, drafts, due dates, and approvals in one place.

### 20. Nominalization: actions frozen into nouns

**Watch for:** perform an analysis of, provide assistance to, make a decision,
conduct a review of, carry out an inspection, has the ability to, is responsible
for the management of.

Use the verb. "Analyze the log," not "perform an analysis of the log." "Decided,"
not "made a decision." "Can," not "has the ability to." This is also
[ASD-STE100 Rule 3.7](clarity-rules.md#verbs-not-nouns).

### 21. Phrasal verbs and soft business verbs

**Watch for:** spin up, reach out, dive into, kick off, circle back, touch base,
roll out, take off, drill down, unpack.

A two-word verb has meanings the parts do not predict, which is why STE bans them
outright ([Rule 9.3](clarity-rules.md#no-phrasal-verbs)). Use the single plain
verb: start, contact, read, begin, deploy, remove.

### 22. Passive voice and missing subjects

**Before:** No configuration file needed. The results are preserved automatically.

**After:** You do not need a configuration file. The system preserves the results
automatically.

Active voice with a named actor, unless the actor is genuinely unknown, genuinely
irrelevant, or deliberately de-emphasized. Never let an inanimate thing do a human
verb: "the decision emerged" is nobody deciding anything.

### 23. The cliche stack

A sentence carrying three or more stock business compounds at once:
cross-functional, data-driven, client-facing, end-to-end, best-in-class,
mission-critical, results-oriented.

**Before:** The cross-functional team delivered a high-quality, data-driven report
on our client-facing tools.

**After:** Four engineers and two designers measured how customers actually use the
dashboard, and wrote up what they found.

Note what this is *not*: a hyphenation problem. Keep the hyphen in a compound
modifier before a noun. See [ruling 8](../SKILL.md#8-hyphenated-word-pairs).

---

## E. Formatting

### 24. Em dashes and en dashes

Default to zero in the final text. Replace each with a period, comma, colon, or
parentheses, or rewrite the sentence. Also catch spaced dashes and double hyphens
used as dashes. Full rule and its two exceptions:
[ruling 3](../SKILL.md#3-em-dashes-and-en-dashes).

**Before:** The term is primarily promoted by Dutch institutions—not by the people
themselves. You don't say "Netherlands, Europe" as an address—yet this mislabeling
continues—even in official documents.

**After:** The term is primarily promoted by Dutch institutions, not by the people
themselves. You don't say "Netherlands, Europe" as an address, yet this
mislabeling continues in official documents.

**Before:** The new policy — announced without warning — affects thousands of
workers. The changes -- long overdue according to critics -- will take effect
immediately.

**After:** The new policy, announced without warning, affects thousands of workers.
The changes, long overdue according to critics, will take effect immediately.

### 25. Decorative bold

**Before:** It blends **OKRs (Objectives and Key Results)**, **KPIs (Key
Performance Indicators)**, and visual strategy tools such as the **Business Model
Canvas (BMC)** and **Balanced Scorecard (BSC)**.

**After:** It blends OKRs, KPIs, and visual strategy tools like the Business Model
Canvas and Balanced Scorecard.

Bold marks structure, not emphasis. See [ruling 14](../SKILL.md#14-bold-text).

### 26. Bold mini-heading lists

**Before:**

- **User Experience:** The user experience has been significantly improved with a
  new interface.
- **Performance:** Performance has been enhanced through optimized algorithms.
- **Security:** Security has been strengthened with end-to-end encryption.

**After:** The update improves the interface, speeds up load times through
optimized algorithms, and adds end-to-end encryption.

The fault is the label followed by a sentence restating the label, not the list
itself. Keep the label or keep the sentence. Lists themselves are fine and often
right: see [Lists are allowed](../SKILL.md#lists-are-allowed).

### 27. Emoji as decoration

**Before:**

> 🚀 **Launch Phase:** The product launches in Q3
> 💡 **Key Insight:** Users prefer simplicity
> ✅ **Next Steps:** Schedule follow-up meeting

**After:** The product launches in Q3. User research showed a preference for
simplicity. Next step: schedule a follow-up meeting.

No emoji in headings, and none as bullet markers. An emoji inside casual prose,
where the writer's own voice uses them, is not this pattern.

### 28. Heading faults

Two shapes, both common:

**Title case where the house style is sentence case.** "## Strategic Negotiations
And Global Partnerships" becomes "## Strategic negotiations and global
partnerships." See [ruling 10](../SKILL.md#10-heading-case).

**A heading restated by its first sentence.**

**Before:**

> ## Performance
>
> Speed matters.
>
> When users hit a slow page, they leave.

**After:**

> ## Performance
>
> When users hit a slow page, they leave.

Also cut headings that sit over a two-sentence section. If the section is that
short, it is a paragraph.

### 29. Mixed quote styles

Straight quotes in code, CLI text, Markdown source, YAML, and JSON. Curly quotes
in typeset prose. The tell is mixing both in one document, not the presence of
either. See [ruling 9](../SKILL.md#9-curly-quotes).

---

## F. Chatbot residue

### 30. Assistant text left in the output

**Watch for:** I hope this helps, Of course!, Certainly!, You're absolutely right,
Great question, Would you like, Want me to, Should I continue, let me know if,
here is a, feel free to ask.

**Before:** Here is an overview of the French Revolution. I hope this helps! Let me
know if you'd like me to expand on any section.

**After:** The French Revolution began in 1789 when financial crisis and food
shortages led to widespread unrest.

Includes the sycophantic opener: "Great question! You're absolutely right that this
is a complex topic" becomes "The economic factors you mentioned are relevant here."

---

## G. Performed personality

Voice and Plain registers only. In Precise there is no personality to perform.

### 31. Throat-clearing, fake candour, and announcements

**Watch for:** Here's the thing, The thing is, Let me be clear, I'll be honest,
Honestly?, Look, Real talk, Let's be honest, Let's dive in, let's explore, let's
break this down, here's what you need to know, now let's look at, without further
ado, heads up, quick note, before I forget, one thing that bit me.

Remove the announcement and state the point. The casual register version is the
same fault in different clothes.

**Before:** Is it worth the price? Honestly? It depends on how often you'll use it.

**After:** Whether it's worth the price depends on how often you'll use it.

**Before:** Let's dive into how caching works in Next.js. Here's what you need to
know.

**After:** Next.js caches data at multiple layers, including request memoization,
the data cache, and the router cache.

**Before:** One thing that bit me hard, so pay attention to this part: the webpack
dev server doesn't send the CORS header by default.

**After:** The webpack dev server doesn't send the CORS header by default.

### 32. Faux insight and pretended depth

**Watch for:** This is the part most people skip, What most people get wrong,
Here's what nobody tells you, The part everyone misses, The real question is, at
its core, in reality, what really matters, fundamentally, the deeper issue, the
heart of the matter, the uncomfortable truth is.

These flatter the writer as the lone expert. Cut the setup and let the claim stand.

**Before:** The part everyone misses: distribution is the real moat.

**After:** Distribution is the moat.

**Before:** The real question is whether teams can adapt. At its core, what really
matters is organizational readiness.

**After:** The question is whether teams can adapt. That mostly depends on whether
the organization is ready to change its habits.

Also cut rhetorical setups of the same family: "What if I told you," "Think about
it:", "Plot twist:", and self-answered question-then-answer pairs.

### 33. Interpretive metadiscourse

Lines that step outside the subject to tell the reader what to notice or how much
weight to give it: "That last part matters more than it sounds," "The key point
is," "As you can see," "This distinction matters," and a redundant "In other
words."

If the point is already clear, delete the aside. If it is not clear, replace the
aside with the supporting fact.

### 34. Formulaic sayings and fake-profound kickers

**Watch for:** X is the Y of Z, X becomes a trap, X is not a tool but a mirror, the
language of, the currency of, the architecture of.

**Before:** Symmetry is the language of trust. Efficiency becomes a trap when teams
forget the human layer.

**After:** Symmetric layouts often feel more predictable to users. Teams can
over-optimize workflows and miss how people actually use them.

**The closing kicker is the worst case.** When a piece ends on a cute metaphor,
aphorism, or mic-drop line, **delete it**. Do not rewrite it into a better
metaphor and do not preserve its rhythm. End on the clearest concrete sentence
already in the draft. If the ending needs closure, add a plain takeaway or a next
action.

### 35. Answering objections nobody raised

**Watch for:** This isn't really about, I'm not saying, I'm not arguing, To be
clear, Don't get me wrong, This is not to say, You could argue, Some might say ...
but, A tempting approach would be, One might be tempted to, It would be easy to
just.

Two shapes. The unattributed self-defense against an objection that appears nowhere
in the text, and the fake alternative introduced, dismissed in a clause, and never
mentioned again. Both usually record an earlier drafting decision that should not
have survived into the final text.

**Before:** This isn't mainly about prompt length, and I'm not arguing that
documentation doesn't matter. You could categorize the problem another way, but the
issue is whether the agent can use the instruction when it acts.

**After:** The issue is whether the agent can use the instruction when it acts.

**Before:** Session tokens are rotated every 24 hours. A tempting approach would be
to rotate them by restarting the auth service on a cron job, but that would drop
every active session. Rotation happens in place, and clients refresh transparently.

**After:** Session tokens are rotated every 24 hours, in place, and clients refresh
transparently.

One rejected option can be legitimate, especially in a design document. Several
short unrelated rejections are the tell. Keep an objection the text names a source
for or answers in full.

---

## H. Filler, hedging, endings

### 36. Filler phrases

- "In order to achieve this goal" becomes "To achieve this"
- "Due to the fact that it was raining" becomes "Because it was raining"
- "At this point in time" becomes "Now"
- "In the event that you need help" becomes "If you need help"
- "The system has the ability to process" becomes "The system can process"
- "It is important to note that the data shows" becomes "The data shows"

**Often-empty phrases:** it's worth noting, it's important to note, at the end of
the day, when it comes to, in today's world, in the age of, in the world of, the
reality is, the truth is, in terms of, with regard to, going forward, in this
article.

Cut them when they delay the point. Keep one when it belongs to the writer's
recognizable voice and the sentence still earns its place.

**Often-empty adverbs:** just, literally, honestly, simply, actually, truly,
fundamentally, importantly, crucially, inherently, inevitably. Cut them when they
add nothing. Keep them when they carry emphasis, contrast, real uncertainty, or the
writer's spoken rhythm.

### 37. Stacked hedging

**Watch for:** to be fair, it's also possible, could potentially, might arguably,
in some cases it may, this is an inference.

**Before:** It could potentially possibly be argued that the policy might have some
effect on outcomes.

**After:** The policy may affect outcomes.

Keep exactly one hedge, the one that states the writer's real confidence. Never
strip the last hedge to make a sentence shorter: that changes the claim. See
[ruling 6](../SKILL.md#6-hedging-versus-modality). Also cut caveats that exist only
to repair an earlier overstatement, and fix the overstatement.

### 38. Generic positive endings and summary recaps

**Watch for:** In conclusion, Ultimately, Overall, The future looks bright,
Exciting times lie ahead, a step in the right direction, on a journey toward.

**Before:** The future looks bright for the company. Exciting times lie ahead as
they continue their journey toward excellence. This represents a major step in the
right direction.

**After:** Cut the paragraph. End on the last concrete fact. If the source states
real plans, use those.

A closing paragraph that restates the piece is the same fault. The reader was just
there. End on the last concrete point, takeaway, or next action.

---

## What is not a tell

Do not treat any of these as evidence by itself. Roughly a third of the patterns
above have an innocent twin, and cutting the twin is how an edit strips a real
person's voice.

- **Perfect grammar and consistent style.** Many writers are professionals or have
  been edited. Polish is not proof.
- **Mixed casual and formal register.** Reflects the writer's field, age, or
  habits.
- **Bland or dry prose.** AI prose has *specific* tells. Dryness without them is
  just dry writing.
- **Formal or academic vocabulary.** Tell 18 names specific overused words. Do not
  simplify every formal word you meet.
- **A letter-style opening or sign-off.** Salutations predate chatbots by
  centuries.
- **One transition word.** "Additionally," "moreover," and "consequently" are tells
  only when piled up. One "however" is nothing.
- **Curly quotes alone.** macOS, Word, Google Docs, and most content systems curl
  quotes automatically.
- **Em dashes alone.** Editors and journalists use them heavily. A dash is evidence
  only alongside formulaic sales rhythm.
- **One short sentence for emphasis.** Flag fragments only when several run
  together.
- **Deliberate repeated openings.** "She came. She saw. She conquered." is rhetoric,
  not a defect.
- **"Honestly" or "look" mid-sentence.** Ordinary in casual writing. The tell is
  the standalone theatrical opener.
- **Real limits and disclaimers.** Keep scope statements, legal and safety notices,
  genuine corrections, named objections, replies, and FAQ answers.
- **Real alternatives.** Keep options a reader would actually consider in a design
  document, tutorial, or argument.
- **Unsourced claims.** Most writing is unsourced. That proves nothing about
  authorship.
- **Clean, complex formatting.** Templates and visual editors produce it without
  any AI.
- **Bullets and numbered lists.** Never a tell on their own. See
  [Lists are allowed](../SKILL.md#lists-are-allowed).
- **Secondhand text.** Never rewrite a watched phrase inside a quotation, a title,
  a proper name, or an example where the phrase is being discussed rather than
  used.
- **Anything written before 30 November 2022.** ChatGPT's public launch.

When unsure, look for several patterns together. One dash proves nothing. Four
stock patterns in one paragraph is a signature.

## Human details to keep

These carry the writer's voice. Keep them unless they damage the meaning.

- **Specific, odd details.** A real address, a strange quote, "the lawyer who used
  to work upstairs from my dentist."
- **Mixed feelings and unresolved tension.** "I think this is mostly good, but it
  bothers me and I can't fully explain why."
- **Dated, era-bound references.** Slang, memes, and in-jokes tied to one year and
  one subculture. Models lag by a year or more.
- **Deliberate first-person choices** the writer can explain.
- **Uneven sentence length.** Real writing alternates. AI drifts toward an even
  mid-length cadence.
- **Genuine asides and self-corrections.** "(I keep wanting to say 'almost' here,
  but it really was certain.)" Models rarely interrupt themselves.
- **Profanity, bluntness, and strong opinions** that belong to the writer. Do not
  make them safer or more professional.
- **Digressions and detours** that carry personality, even when they cost
  tightness.
