# Installing for any coding agent

This skill is a directory of Markdown plus five POSIX shell scripts. No build step,
no runtime, no dependencies. Any agent that reads the
[Agent Skills](https://agentskills.io) format runs it unchanged, and the agents that
have no skill system can still load it through a rules file.

- [Fastest path](#fastest-path)
- [Why one directory covers most agents](#why-one-directory-covers-most-agents)
- [Agents with native skill support](#agents-with-native-skill-support)
- [Agents that install through their own CLI or account](#agents-that-install-through-their-own-cli-or-account)
- [Every other Agent Skills client](#every-other-agent-skills-client)
- [Agents with no skill system](#agents-with-no-skill-system)
- [Checking that it loaded](#checking-that-it-loaded)
- [Keeping it current](#keeping-it-current)
- [Sources](#sources)

## Fastest path

```bash
git clone https://github.com/sarrafgsarraf/humanize-text-pro.git
cd humanize-text-pro
./scripts/install.sh
```

The installer detects which agents are present on the machine and writes the skill
to each one's documented directory. Nothing is downloaded and nothing is executed
from the network. It copies the directory you just cloned.

```bash
./scripts/install.sh --list        # every known path and whether it exists here
./scripts/install.sh --dry-run     # print what would happen, change nothing
./scripts/install.sh --all         # write every known path, detected or not
./scripts/install.sh --project     # install into the current repo instead of $HOME
./scripts/install.sh --uninstall   # remove it from every known path
```

Use `--project` when you want the skill committed alongside a codebase so everyone
who clones it gets the same editing rules.

## Why one directory covers most agents

`~/.agents/skills/` is the vendor-neutral location in the Agent Skills standard.
At the time of writing it is read by Codex, Cursor, Gemini CLI, GitHub Copilot,
OpenCode, Amp, Goose, Junie, Roo Code, Factory Droid, and DeepSeek Harness. Google
Antigravity reads the project-level `.agents/skills/` equivalent.

So the shortest manual install for most setups is one copy:

```bash
mkdir -p ~/.agents/skills
cp -R humanize-text-pro ~/.agents/skills/
```

The per-agent paths below still matter for the agents that do not read the neutral
path (Claude Code, Kiro, Hermes, Antigravity at user level) and for anyone who
prefers keeping each agent's configuration self-contained. `install.sh` writes both.

## Agents with native skill support

Every path here comes from that vendor's own documentation, linked in
[Sources](#sources). Paths do change. When one is wrong, the vendor's page is the
authority, not this table.

| Agent | User level | Project level |
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

Where an agent lists several paths it reads all of them, usually with the
agent-specific one winning on a name clash. Writing to one is enough.

### Claude Code

As a plugin, which also gives you `/humanize-text-pro`:

```bash
claude plugin marketplace add sarrafgsarraf/humanize-text-pro
claude plugin install humanize-text-pro@humanize-text-pro
```

Or as a plain directory:

```bash
cp -R humanize-text-pro ~/.claude/skills/
```

A newly installed skill is not invocable until Claude Code restarts, because the
skill list is fixed when a session starts.

### Codex, Cursor, Copilot, Gemini CLI, DeepSeek Harness, OpenCode, Amp, Goose, Junie, Roo Code, Factory

All of these read the neutral path, so one copy serves them:

```bash
mkdir -p ~/.agents/skills && cp -R humanize-text-pro ~/.agents/skills/
```

Restart the agent, or start a new session, so it rescans. Codex picks up local skill
changes on its own but may need a restart if a new skill does not appear.

### Google Antigravity

Antigravity's user-level skills live under its Gemini config directory rather than
the neutral path:

```bash
mkdir -p ~/.gemini/config/skills && cp -R humanize-text-pro ~/.gemini/config/skills/
```

For a single workspace, use `.agents/skills/` in the project root instead.
Antigravity also reads `AGENTS.md` and `GEMINI.md` as rules, and workspace rules from
`.agents/rules/`, but a skill is the right shape for this: it loads only when
relevant instead of sitting in context permanently.

### Kiro

```bash
mkdir -p ~/.kiro/skills && cp -R humanize-text-pro ~/.kiro/skills/
```

## Agents that install through their own CLI or account

### Hermes Agent

Hermes has its own installer, which accepts a URL to a `SKILL.md`:

```bash
hermes skills install https://raw.githubusercontent.com/sarrafgsarraf/humanize-text-pro/main/SKILL.md
```

That pulls the skill file and its referenced support files. To get the whole
directory including the scripts, copy it instead. Hermes allows subdirectories, so
grouping is fine:

```bash
mkdir -p ~/.hermes/skills/writing && cp -R humanize-text-pro ~/.hermes/skills/writing/
```

### Claude, Claude CoWork, and claude.ai

CoWork loads skills from your Claude account, not from a directory on disk, so a file
copy will not reach it. Package the directory and upload it:

```bash
cd humanize-text-pro
zip -r -X ../humanize-text-pro.zip . -x '*.git*' -x '*.DS_Store'
```

Then, on claude.ai, go to Settings, Capabilities, Skills, and upload the zip. It
becomes available in CoWork and in Claude chat.

## Every other Agent Skills client

The Agent Skills format is supported by around fifty products. If yours is below,
the skill works there. Follow that product's own setup page for where its skills
directory lives, then copy the `humanize-text-pro` directory into it.

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
| Piebald | [piebald.ai](https://piebald.ai) |

Many of these read `~/.agents/skills/` too, so try the one-copy install first and
check whether the skill shows up before hunting for a product-specific path. The
current list of supporting products is at
[agentskills.io/clients](https://agentskills.io/clients).

## Agents with no skill system

Some agents load standing instructions from a rules or context file instead of
discovering skills by description. The skill still works there. You lose only the
on-demand loading: the agent reads the pointer every session and opens the skill
files when the pointer tells it to.

Two steps.

**1. Put the skill somewhere the agent can read**, inside the repo so paths stay
stable for everyone:

```bash
./scripts/install.sh --project      # writes .agents/skills/humanize-text-pro/ and friends
```

**2. Add a pointer to that agent's rules file.** Paste this block:

```markdown
## Writing and editing prose

Before writing or editing any prose (documentation, commit bodies, pull request
descriptions, release notes, user-facing copy, or any message sent outside this
team), read `.agents/skills/humanize-text-pro/SKILL.md` and follow it. Read
`references/ai-tells.md` in that directory before your first edit, and check the
result against `checks/eval.md` before returning it.

Do not invent facts, sources, or numbers to make a sentence read better, and do not
weaken a hedge into a certainty.
```

Where that block goes:

| Agent | Rules file |
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
Zed, Ona, Factory, Antigravity, and DeepSeek Harness all read it, so an agent you do
not see anywhere on this page will most likely pick up a pointer placed there.

One caution if you add the pointer to `AGENTS.md`: this repository already has an
`AGENTS.md`, and it is a guide for modifying the skill, not project instructions for
your codebase. Write your pointer into your own project's `AGENTS.md`; do not copy
this repo's.

## Checking that it loaded

Ask the agent directly:

```
list your available skills
```

Or give it something to fix, which tests discovery and behavior at once:

```
humanize this: Here's the thing, our robust platform leverages cutting-edge AI to
seamlessly empower teams, marking a pivotal moment for the industry.
```

A working install rewrites that into plain language, cuts the sales adjectives and
the inflated significance, and does not invent a product detail to replace them. If
the agent ignores it, the usual causes are these, in order of likelihood:

1. The session started before the install. Restart the agent.
2. The skill went to a path that agent does not read. Run `./scripts/install.sh --list`.
3. The workspace is untrusted. Gemini CLI, for one, requires a trusted folder for
   project-level skills; user-level skills are unaffected.
4. Two skills share the `name` in frontmatter, and the other one won. Some agents
   take the first match rather than reporting the clash.

## Keeping it current

Re-run the installer after pulling:

```bash
git pull && ./scripts/install.sh
```

The installer replaces each destination rather than merging into it, so a file
deleted upstream does not survive locally.

This repository also tracks its three source skills. `.github/workflows/upstream-sync.yml`
runs weekly, and `./scripts/check-upstream.sh` compares each pinned SHA in
`upstream.json` against that repository's current default branch. See the README for
why the sync opens a review pull request instead of applying upstream changes
automatically.

## Sources

Skill directory paths above are taken from these pages. When a path here disagrees
with one of them, believe the vendor.

- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [Claude Agent Skills overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
- [OpenAI Codex skills](https://developers.openai.com/codex/skills/)
- [Cursor skills](https://cursor.com/docs/context/skills)
- [GitHub Copilot agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)
- [VS Code agent skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Gemini CLI skills](https://geminicli.com/docs/cli/skills/)
- [Antigravity skills codelab](https://codelabs.developers.google.com/getting-started-with-antigravity-skills)
- [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)
- [OpenCode skills](https://opencode.ai/docs/skills/)
- [Amp skills](https://ampcode.com/docs/customize/skills)
- [Goose skills](https://block.github.io/goose/docs/guides/context-engineering/using-skills/)
- [Hermes Agent skills](https://hermes-agent.nousresearch.com/docs/user-guide/features/skills)
- [JetBrains Junie agent skills](https://junie.jetbrains.com/docs/agent-skills.html)
- [Roo Code skills](https://docs.roocode.com/features/skills)
- [Kiro skills](https://kiro.dev/docs/skills/)
- [Factory Droid skills](https://docs.factory.ai/cli/configuration/skills)
- [Agent Skills specification](https://github.com/agentskills/agentskills) and the
  [client showcase](https://agentskills.io/clients)
- [Warp rules](https://docs.warp.dev/knowledge-and-collaboration/rules)
- [AGENTS.md](https://agents.md/)
