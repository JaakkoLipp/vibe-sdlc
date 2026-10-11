# Phase 3: Design

**Purpose:** plan the solution that satisfies every requirement. That means:
- the overall architecture: major components, data model, interfaces;
- detail where it matters: screen layouts, business rules, process flows;
- a phased roadmap where every milestone can be planned and verified on its own.

**Inputs:** product.md and requirements.md (both approved), and the existing code, if any.
**Outputs:** `architecture.md`, `roadmap.md` and `runbook.md` (from the templates), plus spike results in `decisions.md`.

## The cycle in this phase

**Plan.** List the design decisions that are needed (stack, storage, structure, hosting, auth and so on) and the **top 1–3 technical risks**. Each risk gets a spike if it could invalidate the architecture. Spikes are time-boxed and throwaway, live in `spikes/<name>/` or on a branch, and their only output is a D-n entry.

**Implement.**
1. **Run the spikes first.** If one disproves an assumption, use *Revising plans* (cycle.md) before designing on top of it.
2. **Architecture** (`architecture.md`, ≤150 lines):
   - context: the system boundary and external systems;
   - components C-n and their responsibilities;
   - data model;
   - interfaces (API shapes, screens);
   - key flows as Mermaid sequence or flow diagrams;
   - business rules;
   - cross-cutting concerns:
     - security and privacy: a light threat model of the top 3 abuse cases,
     - error handling,
     - observability,
     - configuration and secrets.
   - **Stack:** prefer boring, mainstream tools that agents know well. Every choice gets a reason. If there's a real fork, give 2–3 options with a recommendation and ask the user.
   - **Detail design** only where a wrong guess is expensive: screen layouts as wireframes for UI requirements, pseudo-code for tricky rules, schemas for persisted data.
3. **Deployment target:** decide it now, because M1 has to deploy. The options run from a local production-like build up to the cloud. Record cost and credential needs.
4. **Runbook** (`runbook.md`): the exact commands to install, run, test, lint/typecheck, **capture screenshots or transcripts** and deploy. Pick verification tooling that works on this machine:
   - **Web:** Playwright. Check that `npx playwright --version` works and that a browser is installed (`npx playwright install chromium`). If system dependencies need sudo, tell the user exactly what to run.
   - **CLI:** scripted sessions whose output is saved as a transcript.
   - **API:** curl or HTTP test scripts.
   - **Mobile or desktop:** state what's possible and what will be ⚠️ manual.
   If there's no way to take screenshots, **say so loudly now** rather than at acceptance.
5. **Roadmap** (`roadmap.md`), ordered by **risk first, then value**:
   - **M1 = walking skeleton:** the thinnest end-to-end slice through every layer. It includes the project scaffold, one real journey (even if crude), the test harness, the screenshot/transcript pipeline and a deploy to the chosen target. It proves the runbook.
   - **M2…Mn = vertical slices.** Each delivers user-visible value and lists its FR IDs, a demo/exit criterion and its dependencies. Aim for milestones that fit in one chat session each.
   - Only the roadmap entries get written now. Each milestone's detailed plan is written when that milestone starts (phase 4 Plan).

**Challenge** the architecture and roadmap. Look for:
- **overengineering:** services, layers, abstractions or infrastructure the requirements don't need yet;
- **unmet requirements:** use the traceability check below;
- **conflicting assumptions:** for example the stack versus a constraint, or the hosting versus the data rules;
- missing security or failure handling;
- an M1 that isn't really end to end;
- milestones that are horizontal layers ("build the DB layer") instead of slices.

**Verify.**
- **Traceability:** every Must FR/NFR maps to at least one C-n **and** exactly one milestone. Every C-n serves at least one requirement. Put this table in architecture.md.
- All spikes are resolved.
- The runbook commands exist for every verification type you'll need.
- Present the architecture (diagram, stack and why), the roadmap and the top risks.

**Update.** Write D-n for every architectural decision, then commit and run the Design gate.

## Exit criteria
- Traceability is complete.
- The spikes are resolved.
- M1 is a true walking skeleton.
- The runbook covers verification.
- The user has approved at the **Design gate**.
