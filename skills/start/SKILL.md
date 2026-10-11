---
name: start
description: Start a new project (or adopt an existing repo or existing requirements docs) under the vibe-sdlc framework. Takes a problem statement or an idea, sets up docs/sdlc/ and git, then guides the user through concept, requirements and design. Use when the user says "start a project with vibe-sdlc", "let's build <idea> properly", or runs /vibe-sdlc:start.
argument-hint: "<the problem or idea, in a sentence or two>"
---

# Start a vibe-sdlc project

Problem or idea: $ARGUMENTS

If that's empty, use the user's latest message. If there's still nothing, ask in one plain-text question what problem they want to solve, then stop.

1. **Already started?** If `docs/sdlc/STATE.md` exists, don't start over. Say where the project stands in two lines, then follow the `vibe-sdlc:next` skill instead.
2. **Read the playbook:** `${CLAUDE_PLUGIN_ROOT}/framework/cycle.md`. It defines the cycle, the gates, the user levels, user actions and the rules for asking questions. Follow it throughout.
3. **Check the directory.**
   - If it isn't a project folder (for example the home directory, or a folder of unrelated files), suggest creating a new folder for this project, give the commands, and stop.
   - **Empty:** this is greenfield.
   - **Existing code:** adopt it. Do a quick read of the README, manifests and layout, using an `Explore` agent if the repo is large. The existing code is the baseline.
   - **Existing docs:** look for a PRD, spec, requirements, ADRs or design notes in the repo, or in what the user gave you. If they exist, the entry point is **existing docs**.
4. **Profile the user.** Choose `novice`, `experienced` or `expert` from what they said and how they said it (see *Adapting to the user* in cycle.md). If you can't tell, add one question to your first round, e.g. "How technical are you?" with the options *Not technical* / *Some coding* / *Professional developer*.
5. **Size it** by what needs building *and* operating (see *Size* in cycle.md). State the size in one sentence with your reason. The user can override it. Size never decides which phases get skipped.
6. **Git.** Check that `git --version` works. If git is missing, installing it is a user action (*When the user must act*). If this isn't a git repository, run `git init`. If there are uncommitted changes, ask before the first commit, so you never sweep someone's half-finished work into a framework commit.
7. **Set up the docs.**
   - Create `docs/sdlc/` with `STATE.md` and `decisions.md`, copied from `${CLAUDE_PLUGIN_ROOT}/framework/templates/`.
   - In STATE.md, fill in the project name, size, user level, entry point, `Phase: 1 Concept`, the next action and the continuation prompt.
   - Add the pointer line to `CLAUDE.md` (create the file if needed): `Project process: vibe-sdlc. Read docs/sdlc/STATE.md before working.`
   - Commit with `sdlc: bootstrap`, following *Committing* in cycle.md. Stage only the files you just created.
8. **Introduce the process.** Adapt it to the user, and do this only on this first run.
   - **Novice:** 3–4 plain sentences. We'll pin down the problem together, then plan, then build in small steps. You stop for their OK at key points. They can type `continue` in any new chat.
   - **Expert:** two lines covering the phases, the gates and the continuation prompt.
9. **Begin.**
   - **From a problem or idea:** read `${CLAUDE_PLUGIN_ROOT}/framework/phases/1-concept.md` and run its cycle, starting at Plan, through to the Concept gate.
   - **From existing docs:** import them into `product.md` and `requirements.md` (and `architecture.md`, if the docs cover design), using the templates. Link the source docs and keep the user's decisions as constraints. Mark the gaps as assumptions or open questions. Then run the `vibe-sdlc:challenger` agent on the imported set, as a subagent even if the project is tiny, because imported docs are where hidden gaps live. Fold in its findings, then run the **Import gate**. After approval, continue with the first phase the docs don't cover, which is usually 3 Design.
