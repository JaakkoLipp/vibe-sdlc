# Phase 7: Evolve

**Purpose:** keep the product useful after release. Feedback, bugs and new ideas turn into new milestones that go back through phases 4 → 5 (→ 6 to redeploy).

## Intake

For every item (a bug, a feature request, feedback or tech debt):

1. **Classify it.**
   - **Bug:** existing behaviour violates an acceptance criterion. Add a regression test that reproduces it, then run the fix through a small cycle.
   - **Change:** a new or changed requirement. Use *Revising plans* (cycle.md). This updates requirements.md, with new FR IDs or changes marked against the old ones, and possibly architecture.md.
   - **Debt:** internal quality issues (dependencies, refactors, flaky tests). Plan it as its own milestone, because mixing it into feature milestones hides it.
2. **Triage** it into `roadmap.md`, either into the next milestone or a new one, ordered by risk and value. The user sets the priority at the next Milestone gate.
3. Update STATE.md: set `Phase: 4 Construction · M<next>`, then commit.

## Lightweight path for small fixes
A single bug fix or small tweak still runs the cycle, compressed into one sitting:
- a 3-line plan;
- an inline challenge;
- the fix plus a regression test;
- verify in the running app;
- update with a commit and a line in `decisions.md` if anything was decided.

It needs a milestone file only if it touches more than a couple of files. There's no gate unless the fix changes behaviour the user cares about.

## Periodic health check (suggest it every few milestones)
- Do the docs still match the code? Check that architecture.md, the runbook commands and the roadmap reflect reality.
- Are dependencies out of date, or do they have known vulnerabilities?
- Are any tests slow, flaky or skipped?
- Does the product still meet its success metrics from product.md?
