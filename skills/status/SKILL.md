---
name: status
description: Show where a vibe-sdlc project stands, including its phase, milestone, cycle step, what it's waiting on, roadmap progress and the continuation prompt.
disable-model-invocation: true
---

# Project status

Read `docs/sdlc/STATE.md` and, if it exists, `docs/sdlc/roadmap.md`. If there's no STATE.md, say this repo isn't a vibe-sdlc project and suggest `/vibe-sdlc:start <idea>`.

Reply in at most 15 lines:
- **Now:** phase · milestone · cycle step · what it's waiting on.
- **Phases:** one line, e.g. `1 ✅ 2 ✅ 3 ✅ 4–5 ▶ M2/4 6 ☐ 7 ☐`.
- **Roadmap:** each milestone with its status, one per line.
- **Uncommitted work:** whether `git status --short` shows any, with the file count.
- **Recent discoveries:** the last 3, from STATE.md.
- **Continue with:** the continuation prompt in a fenced block.

Don't change any files.
