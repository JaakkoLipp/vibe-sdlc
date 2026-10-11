# Phase 4: Construction (per milestone)

**Purpose:** build the milestone according to the design. Build and integrate its components, and test them at unit, component and integration level. Full-system testing is phase 5. User docs and help text for the features are written here too.

**Inputs:** the roadmap entry for Mn, the FR IDs it covers, architecture.md, runbook.md and the code.
**Outputs:** working code and tests, plus `docs/sdlc/milestones/Mn-<slug>.md` (from `templates/milestone.md`).

## The cycle in this phase

**Plan.** Write the milestone file (≤80 lines):
- goal and demo criterion;
- the FR/NFR IDs covered;
- ordered steps, where each step lists its files, says what to do and gives a **Verify** check;
- the tests to write, mapped to the acceptance criteria;
- the docs and help to update.

Each step should leave the code working. Read the relevant code first, so the steps name real files and reuse existing patterns.

**Challenge** the milestone plan against the architecture and requirements. Look for:
- **missing cases:** steps without tests, acceptance criteria with no test;
- **unnecessary complexity:** steps that serve no FR, abstractions brought in early for future milestones;
- **conflicting assumptions:** the plan versus the actual code, or versus architecture.md.

**Implement.** You own the change; there are no parallel writers. Go step by step:
1. Write the code and its tests together.
2. Run the step's Verify check.
3. Tick the step in the milestone file.
4. Update STATE.md's cycle step (`Implement · step k/n`).

Follow the codebase's existing conventions. Add the milestone's **acceptance tests** (automated end-to-end checks of its Given/When/Then criteria) wherever the project's tooling allows it.

**Verify** at component and integration level, following the runbook:
- **review your own diff** (`git diff`) against the coding rules in cycle.md. Check that every changed line traces to a step's FR, that there's no speculative code and no unrelated edits, and that anything your change left unused has been removed;
- the full unit and integration suite, lint, typecheck and build;
- **launch the app and walk through the milestone's journey** for real;
- take screenshots of UI states, save them to `evidence/Mn/`, and **look at them**: check for broken layout, error text, empty states and placeholder text;
- for a CLI or API, save a transcript of the real commands and responses.

If any check fails, fix it and verify again. After 3 failed attempts on the same problem, stop and ask the user.

**Update.**
- Log deviations in the milestone's "Changes" section and decisions in `decisions.md`. Use *Revising plans* if an upstream doc is now wrong.
- Commit with `sdlc(Mn): construction complete`.
- Set STATE.md to `Phase 5 Acceptance · Mn · Plan`.

There's no user gate here. Go straight on to phase 5.

## M1 (walking skeleton) also must
- create the project scaffold, test harness and lint/format config, following the runbook;
- prove **every** runbook command, including the screenshot or transcript capture and the deploy. The deploy goes to a production-like local run unless the user approved an external target at the Design gate, and even then confirm right before the first external deploy (see the outward-facing rule in cycle.md). Fix the runbook wherever reality differs;
- add `.gitignore` and `.env.example`. Secrets never go into git.

## Definition of done (every milestone)
- [ ] All the steps are ticked, and the tests for every FR in scope exist and pass.
- [ ] Lint, typecheck and build are clean.
- [ ] The journey has been exercised in the running app, and the evidence is saved.
- [ ] The README, help text and user docs reflect the new behaviour.
- [ ] Changes and decisions are recorded, and the work is committed.
