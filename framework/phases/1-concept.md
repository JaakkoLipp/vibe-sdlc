# Phase 1: Concept

**Purpose:** set out the broad function and form of the product: what it does, for whom, how it feels to use and why it's worth building. This phase is about understanding people's needs and how the product meets them. Don't design the internals yet.

**Inputs:** the user's problem or idea, and any existing code or docs.
**Outputs:** `docs/sdlc/product.md` (from `templates/product.md`) and concept sketches, plus an optional throwaway prototype in `docs/sdlc/concept/`.

## The cycle in this phase

**Plan.** Restate the problem in one paragraph: who has it, and what is really going wrong. If the user brought a problem rather than a solution, the main job of this phase is finding the right solution concept, not polishing the first one that comes to mind. List what's known, what's unknown, and which concept artifacts suit the product:
- **UI product:** user journeys and wireframes of the 2–4 key screens.
- **API or service:** an interaction sequence and example requests and responses.
- **CLI:** example sessions showing commands and their output.
- **Process or automation:** a flow diagram.

**Challenge.** Look for:
- needs nobody stated (who else is affected?),
- journeys with no clear trigger or end,
- an MVP that is really v3,
- a much simpler route to the same outcome (an existing tool, or a smaller concept),
- assumptions that contradict each other (for example "works offline" and "real-time shared").

**Implement**, which is mostly an interview. Use the rules under *Asking the user* in cycle.md, in 1–3 short rounds:
1. **Problem and people:** who has the problem, what they do today instead, and what it costs them. Keep it to one to three personas.
2. **Value and strategy:** why this product, why now, what success looks like (a metric or demo), and constraints such as time, budget, hosting and the user's skill level.
3. **Concept options.** Unless the user has already settled on a solution, propose 2–3 genuinely different ways to meet the need, for example a phone app, a shared spreadsheet, or a bot in a chat app they already use. When an **existing tool or no-code option** plausibly fits, include it, even though it means building nothing. For each option, give what it's like to use, the effort to build, the running cost and the main trade-off. Recommend one.
   - If the user picks an existing tool, help them set it up and record the decision in `decisions.md`. Set STATE.md to `Phase: closed (solved with <tool>)` and stop.
   - If an expert arrives with a decided solution, confirm it in one line and skip this step, unless the challenge finds a much simpler route.
4. **Form:** for the chosen concept, the platform (web, mobile, desktop, CLI, API), look and feel, and the 3–5 core journeys (J-n).
5. **Non-goals:** what this explicitly won't do.

Then write `product.md` and the sketches. Write the sketches as Mermaid flows, ASCII wireframes or a single static HTML mockup (`concept/mockup.html`) with no build step. If one core assumption is technically uncertain (for example "can we get this data from that API?"), run a time-boxed spike now.

**Verify.**
- Every journey traces to a stated need, and every need is served by a journey.
- Render the mockup and screenshot it if browser tooling is available. Otherwise present the ASCII sketches.
- Walk the user through the journeys step by step and ask whether this is what they mean.

**Update.** Write D-n entries for the product decisions, and commit. Then run the Concept gate.

## Exit criteria
- The concept was chosen from real alternatives (or the user had already settled on one), and the choice is logged in D-n.
- `product.md` has a one-line pitch, the problem, users, value, J-1…J-n, the form, success metrics and non-goals.
- Each core journey has a sketch.
- The user has approved it at the **Concept gate**.

## Keep it light
Phase 1 decides *what* and *why*, not *how*. Leave stack choices and data models to phase 3, unless the user mandates them, in which case record them as constraints.
