# vibe-sdlc

A vibecoding framework for Claude Code. It takes a project from idea to deployed product through the SDLC phases. Every step runs the same five-step cycle, and the project's state lives in the repo, so any fresh chat can pick up exactly where the last one stopped.

```
1 Concept ───┐
2 Requirements├── once, kept light       → product.md · requirements.md
3 Design ─────┘                          → architecture.md · roadmap.md · runbook.md
M1 walking skeleton:  4 Construction → 5 Acceptance   (already deploys)
M2 … Mn:              4 Construction → 5 Acceptance
6 Deployment → 7 Evolve (feedback becomes new milestones)

Every step:  Plan → Challenge → Implement → Verify → Update
```

| Step | What happens |
|------|--------------|
| **Plan** | A plan of at most one screen, including *how it will be verified*. Risky unknowns get a time-boxed spike. |
| **Challenge** | A fresh-context `challenger` agent attacks the plan under three headings: missing cases, unnecessary complexity and conflicting assumptions. |
| **Implement** | One agent (the main session) owns the change, following coding rules adapted from the [Karpathy guidelines](https://x.com/karpathy/status/2015883857489522876): think before coding, simplicity first, surgical changes, goal-driven verification. Subagents only explore, review or verify. |
| **Verify** | Evidence, not assertion: tests, launching the app, screenshots that Claude actually looks at, and the real flow. Acceptance is checked by an independent `verifier` agent. |
| **Update** | Decisions and discoveries are logged, docs and STATE.md updated, the next step set, and a git commit made. |

## Who it's for

- **Novices** can start from a plain problem statement ("I keep forgetting to water my plants"). Claude:
  - talks in plain language;
  - proposes 2–3 solution concepts, including "just use an existing app" when that's the honest answer;
  - makes the technical decisions, with a one-line reason for each;
  - walks you through anything only you can do, such as creating accounts, adding API keys or installing tools, one step at a time. Secrets never go through the chat.
- **Experienced and expert engineers** get terse summaries, technical forks put to them as questions, and their stated stack treated as a constraint. If you already have a PRD or spec, `start` imports it instead of interviewing you again. You get one Import gate, a fresh-context challenge of the imported docs, and then straight into design. Ask for speed, and the Import gate folds into the Design gate.

Claude infers your level from how you describe things, or asks once. Change it at any time by saying "treat me as an expert".

## Quick start

Create the directory and move into it:

```bash
mkdir ~/projects/habit-tracker && cd ~/projects/habit-tracker
```

Then open Claude Code there and run:

```
/vibe-sdlc:start my partner and I keep breaking our habit streaks and want to track them together
```

You can describe a problem, an idea, or point it at an existing requirements doc: `/vibe-sdlc:start build the relay described in docs/prd.md`.

Give each project its own directory. If you start in a directory that already has code, the framework adopts that code as the baseline.

## Commands

| Command | Use |
|---------|-----|
| `/vibe-sdlc:start <idea>` | New project, or adopt an existing repo. Sets up `docs/sdlc/` and git, then begins the Concept phase. |
| `/vibe-sdlc:next` | Continue from STATE.md and run cycles until the next gate. Every continuation prompt starts with this. |
| `/vibe-sdlc:status` | Where things stand, plus the continuation prompt. Changes nothing. |
| `/vibe-sdlc:revise <what changed>` | Change control when a prototype or spike shows the plan is wrong. It updates the highest affected doc first and re-plans only what's affected. |

## Gates and fresh chats

Claude stops for your approval at these gates:
- **Import** (only when starting from existing docs)
- **Concept**
- **Requirements**
- **Design** (architecture and roadmap)
- **each milestone's acceptance**
- **Go-live**, both before anything outward-facing or irreversible and after the smoke test
- any **revision** that changes scope or a Must requirement

Between gates it works on its own and only stops for questions that change the outcome.

After each approved gate, Claude suggests starting a fresh chat and gives you a ready-to-paste continuation prompt:

```
/vibe-sdlc:next Continue habit-tracker: 4 Construction · M2 "Streaks" · start at Plan. State: docs/sdlc/STATE.md
```

STATE.md is updated when each cycle step starts and ends, so even an interrupted session (a usage limit, a crash, `/clear`) resumes at the right step. A SessionStart hook shows Claude the current state whenever you open a chat in the project. It prints nothing in other repos.

## What it writes into your project

```
CLAUDE.md                  # one line: "Read docs/sdlc/STATE.md before working"
docs/sdlc/
├── STATE.md               # the hub (≤40 lines): phase, milestone, cycle step, next action, continuation prompt
├── product.md             # product definition and concept sketches (J-n journeys)
├── requirements.md        # FR/NFR with Given/When/Then acceptance criteria, traced to journeys
├── architecture.md        # components (C-n), data, interfaces, flows, security; traceability table
├── roadmap.md             # milestones, risk-first; M1 is a walking skeleton that deploys
├── runbook.md             # install/run/test/screenshot/deploy commands, proven in M1
├── decisions.md           # D-n log of decisions and discoveries, append-only
├── milestones/Mn-*.md     # each milestone's plan, changes and acceptance table
└── evidence/Mn/           # screenshots and transcripts from verification
```

The docs are deliberately short and cross-linked by stable IDs (J, FR, NFR, C, M, D, R), so an agent can work from them alone.

## Sizing

At start, Claude proposes a size, and you can override it:
- **tiny:** phases 1–3 in one sitting with one gate, and 1–2 milestones.
- **standard:** the full flow.
- **large:** phases 1–3 at outline depth, with milestones grouped into releases.

## Plugin layout

```
vibe-sdlc/
├── .claude-plugin/plugin.json
├── skills/{start,next,status,revise}/SKILL.md   # thin entry points
├── framework/                                   # the playbook, loaded on demand
│   ├── cycle.md                                 # cycle, gates, docs, questioning and revision rules
│   ├── phases/1-concept.md … 7-evolve.md        # what each cycle step means in each phase
│   ├── elicitation-checklist.md
│   └── templates/                               # STATE, product, requirements, architecture, roadmap, milestone, decisions, runbook
├── agents/challenger.md                         # read-only critic for the Challenge step
├── agents/verifier.md                           # independent acceptance tester (no product edits)
└── hooks/                                       # SessionStart: show STATE.md if present
```

Always-on cost is about 740 tokens (the skill and agent descriptions). The playbook files load only when a skill runs, and each step reads only its own phase file.

## Install

**From GitHub**, inside Claude Code:

```
/plugin install vibe-sdlc --marketplace JaakkoLipp/vibe-sdlc
```

Or from a shell, add the marketplace:

```bash
claude plugin marketplace add JaakkoLipp/vibe-sdlc
```

Then install the plugin:

```bash
claude plugin install vibe-sdlc@vibe-sdlc
```

**From a local clone** (edits take effect after `/reload-plugins`):

```bash
ln -s "$PWD" ~/.claude/skills/vibe-sdlc
```

**Disable** a GitHub install:

```bash
claude plugin disable vibe-sdlc@vibe-sdlc
```

**Disable** a local clone:

```bash
claude plugin disable vibe-sdlc@skills-dir
```

**Remove** a GitHub install:

```bash
claude plugin uninstall vibe-sdlc@vibe-sdlc
```

**Remove** a local clone:

```bash
rm ~/.claude/skills/vibe-sdlc
```

## Prerequisites for the Verify step

For screenshots of web apps, the framework uses Playwright. The design phase checks for it and puts the exact commands in the runbook, and M1 proves they work. On WSL or Linux, installing browser system dependencies may need `sudo npx playwright install-deps chromium`. If screenshots aren't possible, Claude says so at design time and marks those criteria ⚠️ rather than passing them.

## Design notes

- **Hybrid schedule, same six phases.** Running phases 1–3 once and then repeating 4→5 per milestone avoids waterfall's late surprises. M1 deploys, so deployment problems show up in week one.
- **The challenger and verifier are separate agents** because self-review is weak. The challenger can't edit anything, and the verifier can't touch product code.
- **The gates are enforced by instructions, not hooks.** The skills follow the gate protocol, and the doc `Status:` fields record approvals.
- **Commits happen at every Update step, and nothing is ever pushed.** Each commit is a rollback point. Releases are tagged locally in phase 6.
