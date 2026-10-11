---
name: next
description: Continue a vibe-sdlc project from where it stopped. Reads docs/sdlc/STATE.md, resumes the current phase, milestone and cycle step, and runs cycles until the next gate. Use when the user pastes a vibe-sdlc continuation prompt, says "continue the project" or "next step" in a repo that has docs/sdlc/STATE.md, or runs /vibe-sdlc:next.
argument-hint: "[optional: continuation prompt or instruction]"
---

# Continue the project

Instruction: $ARGUMENTS

## 1. Load the state, and only what this step needs

1. Read `docs/sdlc/STATE.md`. If it doesn't exist, say this repo isn't a vibe-sdlc project yet, suggest `/vibe-sdlc:start <idea>`, and stop.
2. Read `${CLAUDE_PLUGIN_ROOT}/framework/cycle.md`, then the current phase file from `${CLAUDE_PLUGIN_ROOT}/framework/phases/`:
   - `1-concept.md`
   - `2-requirements.md`
   - `3-design.md`
   - `4-construction.md`
   - `5-acceptance.md`
   - `6-deployment.md`
   - `7-evolve.md`
3. Read the inputs that phase file names, and nothing else yet. Context is the scarce resource.
4. If the instruction above conflicts with STATE.md (for example "start M3" while M2 isn't accepted), point out the conflict and ask which should win.

## 2. Work out where you are

- **`Waiting on: <approval>`:** present that gate again (Gate protocol in cycle.md). Do nothing else until it's answered.
- **A step marked `in progress`:** the last session was interrupted. Run `git status` and `git diff --stat` to see the partial work, compare it with the plan's ticked steps, and **resume that step**. Don't redo finished work, and don't throw away uncommitted changes without asking.
- **Otherwise:** start the step named in `Next action`.

Tell the user in one or two lines where you're picking up, for example: "Resuming M2 · Implement · step 3/5 (the streak calculation; 2 files changed since the last commit)."

## 3. Run cycles until a gate

Follow cycle.md: Plan → Challenge → Implement → Verify → Update. Update STATE.md at the start and end of each step, and commit at every Update step. Keep going through cycles and phases on your own until one of these happens:
- you reach a **gate**: run the Gate protocol, finishing with the continuation prompt, then stop;
- a question changes the outcome: ask it, and resume after the answer;
- verification still fails after 3 attempts, or a revision touches scope or a Must requirement: stop and ask;
- the conversation is getting long mid-milestone: finish the current step, update STATE.md, commit, give the continuation prompt, then stop.

When moving from one milestone to the next or from one phase to the next **without** a gate (for example from phase 4 to 5), carry on in the same chat.
