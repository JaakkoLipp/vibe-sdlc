# Phase 2: Requirements

**Purpose:** understand the problem in detail and decide what's needed, by engaging the user. Record the result as a testable specification.

**Inputs:** `docs/sdlc/product.md` (approved) and the code, if any.
**Outputs:** `docs/sdlc/requirements.md` (from `templates/requirements.md`).

## The cycle in this phase

**Plan.** For each journey J-n, list the behaviours it implies. Pick the relevant categories from `${CLAUDE_PLUGIN_ROOT}/framework/elicitation-checklist.md`. Set a round budget: tiny 1, standard 2–4, large 4 or more.

**Implement**, which is elicitation in rounds. Use the rules under *Asking the user* in cycle.md. In each round, take the 1–4 unknowns with the most impact, ask them, then play back "Settled so far". Spend extra attention on what specs usually miss:
- unhappy paths: invalid input, partial failure, timeouts, concurrency, empty states, limits;
- data: where it lives, migration, retention, privacy;
- permissions: who may do what;
- backward compatibility for current users and callers;
- how each requirement will be verified.

**Stop eliciting** when any of these is true:
- the remaining unknowns wouldn't change the design (record them as assumptions);
- the user wants to move on;
- the round budget is spent. List whatever is left under Open questions, each with a "decide by" milestone.

Then write `requirements.md`. Each requirement must be:
- **atomic:** one behaviour each, with an ID (FR-n or NFR-n);
- **EARS-phrased:** *When \<trigger\>, the system shall \<response\>* · *If \<unwanted\>, then …* · *While \<state\>, …*;
- **prioritised:** MoSCoW, and **traced** to the journey J-n or the source it came from;
- **testable:** with Given/When/Then acceptance criteria. **These become the acceptance tests in phase 5**, so write them as someone would actually check them, and avoid words like "fast" or "intuitive" without a number.

**Challenge**, on the draft before the user sees it. Look for:
- ambiguous wording,
- requirements that can't be tested,
- missing unhappy paths,
- requirements that contradict each other,
- requirements that serve no journey (scope creep),
- journeys with no requirement (gaps).

**Verify.**
- Every J-n is covered by at least one FR.
- Every FR traces back to a J-n or another stated source.
- Every Must has at least one acceptance criterion.
- Present a summary at a glance (ID, priority, one line each), plus the assumptions and open questions.

**Update.** Fold every answered question into the requirement text and the decision log. Don't leave "see Q-n" pointers behind. Commit, then run the Requirements gate.

## Exit criteria
- The traceability checks above pass.
- No Must requirement is ambiguous.
- The open questions don't block the design.
- The user has approved it at the **Requirements gate**.
