---
name: start
description: Start a new project (or adopt an existing repo) under the vibe-sdlc framework. Sets up docs/sdlc/, git and the sizing, then begins phase 1 (Concept). Use when the user says "start a project with vibe-sdlc", "let's build <idea> properly", or runs /vibe-sdlc:start.
argument-hint: "<the idea, in a sentence or two>"
---

# Start a vibe-sdlc project

Idea: $ARGUMENTS

If that's empty, use the user's latest message. If there's still no idea, ask for it in one plain-text question and stop.

1. **Already started?** If `docs/sdlc/STATE.md` exists, don't start over. Say where the project stands in two lines, then follow the `vibe-sdlc:next` skill instead.
2. **Read the playbook:** `${CLAUDE_PLUGIN_ROOT}/framework/cycle.md`. It defines the cycle, gates, docs and the rules for asking questions. Follow it throughout.
3. **Look at the directory.**
   - **Empty or near-empty:** this is greenfield.
   - **Existing code:** adopt it. Do a quick read of the README, manifests and layout, using an `Explore` agent if the repo is large. The existing code becomes the baseline, and phase 1 records what exists before adding what's new.
4. **Size it.** Propose tiny, standard or large in one sentence with your reason (definitions are in cycle.md). The user can override it.
5. **Git.** If this isn't a git repository, run `git init`. This framework commits at every Update step and never pushes. If there are uncommitted changes, ask before the first commit, so you never sweep someone's half-finished work into a framework commit.
6. **Set up the docs.**
   - Create `docs/sdlc/` with `STATE.md` and `decisions.md`, copied from `${CLAUDE_PLUGIN_ROOT}/framework/templates/`.
   - In STATE.md, fill in the project name, the size, `Phase: 1 Concept`, the next action and the continuation prompt.
   - Create the other docs only when their phase starts.
   - Add the pointer line to `CLAUDE.md` (create the file if needed): `Project process: vibe-sdlc. Read docs/sdlc/STATE.md before working.`
   - Commit with `sdlc: bootstrap`, following *Committing* in cycle.md. Stage only the files you just created.
7. **Begin phase 1.** Read `${CLAUDE_PLUGIN_ROOT}/framework/phases/1-concept.md` and run its cycle, starting at Plan. Carry on until the Concept gate, and follow the Gate protocol there.

Tell the user, in one short paragraph and only on this first run, how the framework works:
- the phases, and the cycle that each step runs;
- that you'll stop for approval at phase and milestone gates;
- that each gate gives them a continuation prompt for a fresh chat.
