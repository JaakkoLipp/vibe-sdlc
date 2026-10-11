---
name: revise
description: Change control for a vibe-sdlc project. When a prototype, spike, bug or new idea shows the plan is wrong, propagate the change from the highest affected doc downwards (product, requirements, architecture, roadmap, milestone), log the decision and re-plan only what's affected. Use when the user runs /vibe-sdlc:revise or says "the plan needs to change because…".
argument-hint: "<what was learned or what should change>"
---

# Revise the plan

Discovery or change: $ARGUMENTS

If that's empty, use the user's latest message. If it's still unclear what changed, ask in one question.

1. Read `docs/sdlc/STATE.md`, then the *Revising plans* section of `${CLAUDE_PLUGIN_ROOT}/framework/cycle.md`.
2. **Assess the impact.** Read the docs it might affect, then list them in a short table: doc, what changes, and the IDs affected. Classify the change as one of these:
   - **local:** only the current milestone's plan;
   - **design:** architecture or roadmap;
   - **scope:** product or requirements, or any *Must* requirement.
3. **Challenge it** with one question: is there a smaller change that absorbs this discovery? If so, propose it next to the full change.
4. **Gate.** Scope changes need the user's approval (the Revision gate). Ask with options: *Apply full change* / *Apply smaller change* / *Don't change, log as known limitation*, with your recommendation first. Local and design changes go ahead without asking, but you must say what changed.
5. **Apply it top-down.** Edit the highest affected doc first, then each doc below it. Keep IDs stable: strike out removed items and annotate changed ones with `(changed D-n)`.
6. **Re-plan** only the affected milestones in the roadmap. Re-open an accepted milestone only if its acceptance criteria changed.
7. **Update.**
   - Add D-n to `decisions.md`: what was learned, what changed and which docs.
   - Update STATE.md's "Recent discoveries" and its next action.
   - Commit with `sdlc(revise): <summary>`, following *Committing* in cycle.md.
8. Report the result in at most 6 lines: what changed, where, and what happens next. If the current phase can carry on, offer to continue now.
