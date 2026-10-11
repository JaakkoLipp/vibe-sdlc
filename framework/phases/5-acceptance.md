# Phase 5: Acceptance (per milestone, and once for the whole system)

**Purpose:** test the complete system against the requirements, the way a customer would, and prove it meets expectations.

**Inputs:** the milestone file, the acceptance criteria of its FR/NFR IDs in requirements.md, the runbook, and the acceptance criteria of earlier accepted milestones (for regression).
**Outputs:** the acceptance table in the milestone file, evidence in `evidence/Mn/`, and the roadmap status.

## The cycle in this phase

**Plan.** Build the acceptance checklist:
- every acceptance criterion for this milestone's IDs;
- the regression criteria from earlier milestones, at least the Must ones;
- exploratory charters: 2–3 short "try to break it" missions, such as odd inputs, double submits, a slow network or an empty account.

**Challenge.** Look for criteria that can't be tested as written, criteria with no planned check, and journeys that are tested only through mocks and never end to end.

**Implement.** Fill the gaps in the automated acceptance (end-to-end) tests where the tooling allows it. **Don't change product code in this phase.** If a fix is needed, it goes back to phase 4.

**Verify.** Run it independently: launch the `vibe-sdlc:verifier` agent with the milestone file, requirements.md and runbook.md. It didn't write the code. It runs the whole suite, launches the app, works through each criterion and the exploratory charters through the real interface, takes screenshots, and reports ✅/❌/⚠️ per criterion with evidence. Then:
- **Look at the key screenshots yourself** (Read the image files) and spot-check one or two of its ✅ results.
- If anything comes out ❌, go back to phase 4 for this milestone with a fix list, then repeat phase 5.
- ⚠️ (not verifiable here) is allowed, but it's listed explicitly at the gate. It's never quietly counted as passed.

**Update.**
- Write the acceptance table into the milestone file and set its status to `accepted`.
- Mark Mn as done in the roadmap and re-check the next milestone's entry (has anything learned here changed it?).
- Commit, then run the **Milestone gate**: show the acceptance table, the key screenshots, the deviations and what's next.

## Whole-system acceptance (before phase 6)
After the last planned milestone, run one full pass over **every** Must and Should acceptance criterion in requirements.md, end to end on a production-like build. Record it in `milestones/final-acceptance.md`. Only then move on to phase 6.

## Exit criteria
- Every Must criterion in scope is ✅ with evidence.
- Every ⚠️ has been shown to the user.
- No regressions.
- The user has approved at the **Milestone gate**.
