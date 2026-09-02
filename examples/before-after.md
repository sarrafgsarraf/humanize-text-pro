# Worked examples

One full example per register, plus the rule-level pairs that are worth seeing in
isolation. Every "after" here obeys the [four laws](../SKILL.md#the-four-laws): no
invented facts, no lost claims, no manufactured voice.

---

## Voice register: a blog post opener

The register is Voice because this is an opinion piece with a first-person writer.
Personality stays. Sentence-length caps do not apply.

**Before**

> Great question! Here's an essay on this topic. I hope this helps!
>
> AI-assisted coding serves as an enduring testament to the transformative potential
> of large language models, marking a pivotal moment in the evolution of software
> development. In today's rapidly evolving technological landscape, these
> groundbreaking tools—nestled at the intersection of research and practice—are
> reshaping how engineers ideate, iterate, and deliver, underscoring their vital role
> in modern workflows.
>
> At its core, the value proposition is clear: streamlining processes, enhancing
> collaboration, and fostering alignment. It's not just about autocomplete; it's
> about unlocking creativity at scale. The tool serves as a catalyst. The assistant
> functions as a partner. The system stands as a foundation for innovation.
>
> Industry observers have noted that adoption has accelerated from hobbyist
> experiments to enterprise-wide rollouts, from solo developers to cross-functional
> teams. Additionally, the ability to generate documentation, tests, and refactors
> showcases how AI can contribute to better outcomes, highlighting the intricate
> interplay between automation and human judgment.
>
> - 💡 **Speed:** Code generation is significantly faster, reducing friction and
>   empowering developers.
> - 🚀 **Quality:** Output quality has been enhanced through improved training.
> - ✅ **Adoption:** Usage continues to grow, reflecting broader industry trends.
>
> While specific details are limited based on available information, it could
> potentially be argued that these tools might have some positive effect. In
> conclusion, the future looks bright. Exciting times lie ahead as we continue this
> journey toward excellence. Let me know if you'd like me to expand on any section!

**After**

> AI coding assistants make me faster at the boring parts. Not everything, and
> definitely not architecture.
>
> They are good at boilerplate: config files, test scaffolding, repetitive refactors.
> They are also good at sounding right while being wrong. I have accepted suggestions
> that compiled, passed lint, and still missed the point, because I stopped paying
> attention.
>
> People I talk to land in two camps. Some treat it as autocomplete for chores and
> review every line. Others turn it off after it keeps suggesting patterns they do
> not want. Both positions seem reasonable to me.
>
> The productivity claims are the part I cannot get comfortable with. Acceptance
> rates are not correctness, and correctness is not value. If you do not have tests,
> you are guessing about all three.

**What changed**

- Cut the chatbot frame ("Great question!", "I hope this helps!", "Let me know if").
- Cut inflated significance ("enduring testament", "pivotal moment", "evolving
  landscape", "vital role") and sales language ("groundbreaking", "nestled").
- Cut the vague source ("Industry observers have noted"), the false range ("from
  hobbyist experiments to enterprise-wide rollouts"), the shallow -ing padding
  ("underscoring", "showcasing", "highlighting"), and the not-just-X-but-Y contrast.
- Cut the synonym cycle (catalyst / partner / foundation) and the em dashes.
- Replaced the emoji bold-label bullets with prose, because the three items were one
  continuous claim rather than a real list.
- Cut the cutoff hedge ("while specific details are limited"), the stacked hedging
  ("could potentially be argued ... might have some"), and the generic upbeat close.
- Kept the writer's first person and admitted uncertainty, which were already there.

**What was deliberately not done.** No study, statistic, named engineer, or company
was added. An earlier pass of this same example invented a "2024 Google study",
a "55% faster" figure, and two named interviewees. Every one of them was fabricated,
and every one of them made the piece read better. That is exactly why
[law 1](../SKILL.md#the-four-laws) exists.

---

## Plain register: a support reply

The register is Plain because it goes to a customer, needs to be warm, and needs no
personality of its own. Lists are used here because the content is genuinely a
sequence.

**Before**

> Hi Sarah,
>
> Thank you so much for reaching out! Great question. I completely understand your
> frustration and I want to assure you that we take this seriously.
>
> After a thorough investigation, our team has identified that the root cause appears
> to be a potential misconfiguration in your webhook endpoint, which may possibly be
> related to the recent infrastructure migration—a change that reflects our ongoing
> commitment to delivering a seamless, robust, and scalable experience for all our
> valued customers.
>
> Here's what you need to know. In order to resolve this, you'll want to first
> navigate to your settings page and then verify that the endpoint URL has been
> updated, after which you should confirm that the signing secret matches and check
> that your firewall allows our new IP range.
>
> Please don't hesitate to let me know if you have any other questions. We're excited
> to continue supporting you on your journey!

**After**

> Hi Sarah,
>
> Thanks for flagging this. Your webhooks stopped delivering because our
> infrastructure migration last week changed the IP range we send from, and your
> endpoint is still configured for the old one.
>
> Three things to check, in this order:
>
> 1. In Settings, confirm the endpoint URL is current.
> 2. Confirm the signing secret matches the one shown there.
> 3. Allow our new IP range through your firewall.
>
> Step 3 is the one that most likely fixes it. If deliveries are still failing after
> that, reply here and I will pull the delivery logs for your account.
>
> Priya

**What changed**

- Cut the sycophantic opening and the reassurance boilerplate.
- Cut sales language ("seamless, robust, and scalable", "valued customers") and the
  significance padding ("reflects our ongoing commitment").
- Cut the announcement ("Here's what you need to know"), the filler ("In order to"),
  and the upbeat send-off ("your journey").
- Split one 48-word instruction sentence into a numbered list. The content was a
  three-step sequence, so the list is correct here and not slop.
- Removed the em dash.
- Kept the salutation and the sign-off. A letter frame is not an AI tell.

**Hedges kept on purpose.** "Most likely fixes it" stays a hedge. The original said
"appears to be" and "may possibly be related", which is two hedges stacked on one
claim, so one was cut and one survived. Promoting it to "step 3 will fix it" would
assert something the sender does not know.

---

## Precise register: an error message and a tool description

The register is Precise. Flat and literal is correct. Hard caps apply. Personality
is not wanted and would be actively harmful.

### Error message

**Before**

> An error may have occurred while processing your request due to a possible mismatch
> in the expected data format, which could be caused by an outdated client version.

**Faults:** 28 words against a 25-word cap, and three separate claims in one
sentence (an error happened, a format mismatch, a client version).

**Not faults:** "may have occurred" and "could be caused by". The system does not
know what went wrong, and both hedges report that ignorance accurately.

**After**

> Your request may have failed. The cause may be a data format that does not match
> what the server expects. An outdated client can cause this mismatch. Check your
> client version.

An earlier version of this rewrite said "The request failed" and "an outdated client
**is the most common cause**". Both read better and both are wrong: the first asserts
a failure the system only suspects, and the second invents a frequency claim that
appears nowhere in the input. Note also that "may have failed" keeps a compound verb
form the simple-tense rule would otherwise remove. When tense and modality collide,
[modality wins](../references/clarity-rules.md#modality-the-rule-that-outranks-every-other-rule-here).

### Tool description

**Before**

> This tool will attempt to synchronize state across the various backends that have
> been configured, and if a conflict is detected it may resolve it automatically
> depending on the strategy that has been set, or otherwise it will surface the
> conflict for manual review.

**Faults:** 55 words against a 25-word cap, two instructions in one sentence, and
present perfect in both relative clauses ("have been configured", "has been set").

**Not faults:** "will attempt to" and "may resolve". The tool is not promised to
succeed, and the rewrite must not promise it either.

**After**

> The tool tries to synchronize state across the configured backends. If it finds a
> conflict, it reads the configured strategy. If the strategy allows automatic
> resolution, the tool may resolve the conflict without a user. If the tool does not
> resolve the conflict, it reports the conflict for manual review.

The last sentence branches on whether the conflict was resolved, not on what the
strategy allows. That is what "or otherwise" meant: the fallback covers a permitted
resolution that still did not happen.

### Inter-agent instruction

**Before**

> Once the upstream job has completed and assuming no errors were raised, the
> downstream agent should proceed to consume the output artifact, though it is worth
> noting that partial artifacts are sometimes produced under timeout conditions.

**Faults:** 42 words against a 20-word instruction cap, present perfect, stacked
subordinate clauses, and three separate facts in one sentence.

**After**

> Wait for the upstream job to finish with no errors. Then read the output artifact.
> Warning: a timeout can produce a partial artifact.

Two calls worth stating rather than hiding:

- "should proceed to consume" became the imperative "read". STE permits this for
  instructions, where a recommendation addressed to the executing agent is a command.
  Do not make the same move in descriptive text.
- The source's own STE skill adds a fourth sentence here ("Check that the artifact is
  complete before you use it"), and flags it as added content. This skill drops it.
  Under [law 1](../SKILL.md#the-four-laws), a rewrite does not get to supply the
  instruction the author left out, however useful it would be. Flag the gap to the
  user instead.

---

## STE rule-level pairs

Illustrations of the rules in [clarity-rules.md](../references/clarity-rules.md),
paraphrased from public secondary sources. Not quotations from the standard.

| Rule | Before | After | Why |
|---|---|---|---|
| One meaning per word | "Verify the system." / "Check the connections." / "Confirm receipt." | One approved term used consistently for the same action | Three near-synonyms force the reader to guess whether they mean the same thing |
| One part of speech per word | "Oil the valve." | "Apply oil to the valve." | If "oil" is approved only as a noun, using it as a verb breaks the one-word-one-role guarantee |
| Precise verb meaning | "Follow the safety instructions." | "Obey the safety instructions." | "Follow" can mean "come after" or "obey" |
| Simple tense | "We have received the technical reports from HQ." | "We received the technical reports from HQ." | Present perfect adds a second reading. Keep it only when current relevance is the point |
| Verb, not noun | "Perform an inspection of the filter." | "Inspect the filter." | The noun form hides the action and adds a filler verb |
| No phrasal verbs | "Take off the access panel." | "Remove the access panel." | "Take off" also means depart and deduct |
| Noun cluster cap | "the agent task queue priority handler" | "the handler that sets task-queue priority" | Four stacked nouns have several possible groupings |

---

## Audit mode: what a findings report looks like

The user asked "does this read as AI slop?" and did not ask for a rewrite. So there
is no rewrite.

**Input**

> Here's the thing: our new dashboard isn't just a reporting tool—it's a paradigm
> shift. The intuitive interface serves as a centralized hub for your data,
> empowering teams to unlock insights, drive alignment, and accelerate decisions.
> Industry reports suggest that data-driven organizations outperform their peers.
> Ultimately, the future of analytics is here.

**Findings**

| Pattern | Line | Fix |
|---|---|---|
| Throat-clearing opener (tell 31) | "Here's the thing:" | Delete. Start with the claim. |
| Not-just-X-but-Y (tell 11) | "isn't just a reporting tool—it's a paradigm shift" | State what it does. |
| Em dash (tell 24) | same line | Period or comma. |
| Banned AI vocabulary (tell 18) | "paradigm shift", "empowering", "unlock", "drive alignment" | Replace with what the dashboard does. |
| Sales language (tell 2) | "intuitive interface" | Delete, or name the measurement. |
| Avoiding is (tell 19) | "serves as a centralized hub" | "shows all your data in one place". |
| Forced group of three (tell 13) | "unlock insights, drive alignment, and accelerate decisions" | Three abstractions for one idea. Pick the real one. |
| Vague source (tell 8) | "Industry reports suggest" | Name the report or cut the claim. |
| Portability test (tell 5) | the whole second sentence | Would read identically for any product. Replace with a specific capability. |
| Generic positive ending (tell 38) | "Ultimately, the future of analytics is here." | Delete. End on the last concrete fact. |

Ten patterns in five sentences. Note that nothing here is scored, and nothing here
claims an AI wrote it. Want me to edit it?
