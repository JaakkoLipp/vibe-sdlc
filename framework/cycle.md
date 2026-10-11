# The vibe-sdlc playbook

The project goes through the SDLC phases, and every unit of work runs the same five-step cycle. This file holds the rules that apply everywhere. Each phase file in `phases/` says what the steps mean in that phase.

## Schedule

```
1 Concept ───┐
2 Requirements├── once, kept light         → product.md, requirements.md
3 Design ─────┘                            → architecture.md, roadmap.md, runbook.md
M1 walking skeleton:  4 Construction → 5 Acceptance   (already deploys, end to end)
M2 … Mn:              4 Construction → 5 Acceptance
6 Deployment: go-live and handover
7 Evolve: feedback becomes the next milestone (back to 4)
```

Phases 1–3 aren't repeated per milestone. If a later discovery invalidates them, they get **revised** (see below), not redone.

**Sizing** is decided at start and stored in STATE.md:
- **tiny** (an afternoon): run phases 1–3 in one sitting with a single gate. Each doc is a few lines, there are one or two milestones, and the Challenge step is done inline instead of by a subagent.
- **standard:** as described here.
- **large:** phases 1–3 cover the whole product at outline depth. The roadmap groups milestones into releases, and only the next release is detailed.

## The cycle

Run the steps in order. **Update `STATE.md` when a step starts and when it ends.** For example, write `Cycle step: Implement · step 3/5 in progress` on start and `Implement done` on finish. An interrupted session (usage limit, crash, `/clear`) must be resumable from STATE.md plus `git status` alone.

### 1. Plan (short)
Write a short plan, at most one screen, in the phase's document or the milestone file. It covers:
- the goal and its input docs (as links),
- what will be produced,
- **how it will be verified**, decided before implementing,
- the unknowns. If an unknown could sink the plan, schedule a **spike**: a time-boxed, throwaway experiment whose only output is an answer, logged in `decisions.md`.

### 2. Challenge
Have the plan and its inputs attacked by a fresh pair of eyes. Launch the `vibe-sdlc:challenger` agent with the phase, the plan's location and the upstream docs. For tiny projects, do it inline against the same three headings. The findings come back under three headings:
- **Missing cases:** unhappy paths, users, data states, requirements with no coverage.
- **Unnecessary complexity:** anything the goal doesn't need yet.
- **Conflicting assumptions:** between docs, between the plan and the code, or between two answers the user gave.

Fix whatever you can decide yourself. Turn the findings that need the user into questions (see *Asking the user*). Drop nitpicks. Record what changed in the plan in one line.

### 3. Implement
**One agent owns the change**: you, in the main session. Never run parallel writers. Subagents may explore, review or verify (read-only), but they don't edit. Produce exactly what the plan says. If you find the plan was wrong:
- **Trivial** (a file name, an existing helper): carry on and log it in the milestone's "Changes" section.
- **Changes behaviour, scope or interface:** stop and use *Revising plans*.

### 4. Verify
Verification means **evidence, not assertion**. Check against the verification criteria from Plan, using the phase file's methods: run tests, launch the app, take screenshots and look at them, and exercise the real flow from the runbook. Save evidence under `docs/sdlc/evidence/<milestone>/`: screenshots and short output excerpts, not full logs.
- On failure, go back to Implement. After 3 failed fix attempts on the same problem, stop and ask the user, showing what you tried.
- If something can't be verified here (no browser tooling, no credentials), say so clearly and record it as ⚠️ unverified. Never mark it passed.

### 5. Update
1. **Decisions and discoveries:** add any non-obvious decision to `decisions.md` (D-n, a single line each, including its reason). If a discovery contradicts an upstream doc, use *Revising plans* before anything else.
2. **Docs:** tick the steps, set statuses, and keep cross-links correct.
3. **Next:** set STATE.md's `Next action` to the next concrete step. At the end of a milestone, make sure the next milestone's roadmap entry is still right. Only its *detailed* plan waits for its own Plan step.
4. **Commit**, following *Committing* below, with the message `sdlc(<phase or Mn>): <what changed>`.
5. **Gate:** if this step ends a gate (see below), run *Gate protocol*. If not, continue with the next cycle.

## Committing

Every commit made by the framework follows these rules:
- **Stage only what this step created or changed**, by path (`git add <paths>`). Never use `git add -A` or `git add .`.
- Run `git status --short` first. If there are untracked or modified files you didn't touch, the user may have put them there. Leave them unstaged and mention them in one line.
- Never commit anything that looks like a secret (`.env`, keys, tokens, credentials). If one is about to be included, stop and say so.
- Make sure `.gitignore` covers build output and dependencies (venvs, `node_modules`, `dist`, caches) before the first commit that could include them.
- Don't bypass hooks (`--no-verify`). If a pre-commit hook fails, fix the cause, or report it if it isn't yours.
- Never push. A release tag is created locally in phase 6 only.

## Gates (where the user approves)

| Gate | When |
|------|------|
| Concept | end of phase 1: product.md and concept sketches |
| Requirements | end of phase 2: requirements.md |
| Design | end of phase 3: architecture.md and roadmap.md (and the runbook) |
| Milestone | end of phase 5 for each milestone: acceptance evidence |
| Go-live | phase 6, **before** any outward-facing or irreversible step (production deploy, publishing, DNS, paid resources), and again after the smoke test |
| Revision | any change to scope or to a *Must* requirement |

Between gates, run cycles on your own. Stop between gates only for questions that change the outcome, failures you can't fix, or revisions.

### Gate protocol
1. Before asking, set STATE.md to `Waiting on: <gate> approval`, and set its continuation prompt to `… · at <gate> gate (awaiting approval)`. That way, a fresh chat opened now re-presents the gate instead of skipping past it. Commit.
2. Present a summary of what's being approved, not whole files. Include links, the top risks, and the key screenshots or evidence.
3. Ask with these options: *Approve (Recommended)* / *Change something* / *Discuss*. Silence or an answer to a side question doesn't count as approval.
4. On approval:
   - set the doc status to `approved (YYYY-MM-DD)`;
   - tick Progress in STATE.md and set `Waiting on: nothing`;
   - **rewrite** `Next action` as the next concrete step, with no leftover "on approval…" wording;
   - commit.
5. **Hand off to a fresh chat.** Tell the user this is a good point to start a fresh chat, then give a ready-to-paste continuation prompt in a fenced block. Fill in the real values:

   ```
   /vibe-sdlc:next Continue <project>: <phase> · <milestone, if any> "<name>" · start at <cycle step>. State: docs/sdlc/STATE.md
   ```

   Also write this prompt into STATE.md under "Continue in a fresh chat". Then stop.

## Asking the user

- **Don't ask what you can look up.** Check the code, docs and conversation first. Only ask about intent, priorities and trade-offs.
- Only ask questions where different answers lead to a different scope, design or test. For anything else, choose a sensible default and record it as an assumption.
- Ask 1–4 questions per round, with the highest-impact one first. Use `AskUserQuestion` with 2–4 options and the recommended one first, its label ending "(Recommended)". "You decide" is a valid answer: use your recommendation and log it as an assumption.
- Ask open questions ("describe…") in plain text, at most 3, then end your turn.
- If `AskUserQuestion` is unavailable, ask in plain text with numbered questions and lettered options, marking the recommended option.
- After each round, show a "Settled so far" list of at most 8 bullets.

## Revising plans

Plans are hypotheses. When a prototype, spike or implementation reveals something new:
1. Find the **highest** doc it affects, in the order product → requirements → architecture → roadmap → milestone.
2. Update that doc first, then each doc below it. Keep the IDs stable: mark items `~~removed~~` or `(changed D-n)` instead of renumbering them.
3. Log D-n in `decisions.md`: what was learned, what changed, and which docs.
4. Re-plan only the milestones affected. Finished, accepted milestones are re-opened only if their acceptance criteria changed.
5. If scope or a *Must* requirement changed, that's a Revision gate and the user approves it. Otherwise, mention it in your next summary.

## Docs: concise, linked, useful to agents

All project docs live in `docs/sdlc/`. Templates are in `${CLAUDE_PLUGIN_ROOT}/framework/templates/`.

| Doc | Size budget | Owner phase |
|-----|-------------|-------------|
| `STATE.md`: the hub, read first in every session | ≤ 40 lines | all |
| `product.md`: product definition and concept sketches | ≤ 1 page of prose | 1 |
| `requirements.md`: FR/NFR with acceptance criteria | terse; one block per requirement | 2 |
| `architecture.md`: the overall architecture | ≤ 150 lines | 3 |
| `roadmap.md`: milestones, risk-first | ≤ 60 lines | 3, updated in 5 and 7 |
| `runbook.md`: install, run, test, screenshot, deploy | commands, not prose | 3, proven in M1 |
| `milestones/Mn-<slug>.md`: one milestone's plan and results | ≤ 80 lines | 4–5 |
| `decisions.md`: D-n log, append-only | one line each | all |

Rules:
- **Link, don't repeat.** Point to the source with a relative link and an ID (`[FR-3](requirements.md#fr-3)`).
- **Stable IDs:**
  - J-n: user journeys
  - FR-n / NFR-n: requirements
  - C-n: components
  - M-n: milestones
  - D-n: decisions
  - R-n: risks
- Each doc starts with `Status:` and `Updated:`. When creating a doc from a template, replace every placeholder and example row, and delete the template's comments.
- Write for an agent that has *only* these docs. State facts and commands, with no narrative history. Git keeps the history.
- Add a pointer to `CLAUDE.md` so other tools find the state: `Project process: vibe-sdlc. Read docs/sdlc/STATE.md before working.`

## Context hygiene

- Each phase or step only reads the docs it links as inputs. Don't load every doc "just in case".
- Do broad codebase sweeps with an `Explore` agent and have it return file lists, not file dumps.
- Plan for one milestone per chat. If the conversation is getting long mid-milestone, finish the current step, update STATE.md and commit, then hand off with a continuation prompt even if there's no gate.
