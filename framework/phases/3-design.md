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
1. **Stack and toolchain.**
   - Choose the stack: prefer boring, mainstream tools that agents know well, and give every choice a reason. How you decide depends on the user level (*Adapting to the user* in cycle.md). For a novice, you choose. For an expert, their stated preferences are constraints. Otherwise, on a real fork, give 2–3 options with a recommendation and ask.
   - Then check the toolchain by running the version command for each tool the stack needs (`node -v`, `python3 --version`, `go version`, `docker --version` and so on).
   - If a tool is missing: for a novice, prefer a stack that uses what's already installed when it fits just as well. Otherwise, make the install a user action (*When the user must act*), with the exact commands for this OS.
   - Do this before the spikes, because they need the tools.
2. **Run the spikes.** If one disproves an assumption, use *Revising plans* (cycle.md) before designing on top of it.
3. **Architecture** (`architecture.md`, ≤150 lines):
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
   - **Stack:** the choices from step 1, each with its reason (D-n).
   - **Detail design** only where a wrong guess is expensive: screen layouts as wireframes for UI requirements, pseudo-code for tricky rules, schemas for persisted data.
4. **Deployment target:** decide it now, because M1 has to deploy. The options run from a local production-like build up to the cloud. Record cost and credential needs. **Default to local** for M1. An external host is the user's decision: ask for it at the Design gate, and never assume it. For a novice, prefer free hosting that needs the fewest accounts. List any accounts or keys the user will need to create as user actions, so they're shown at the Design gate.
5. **Runbook** (`runbook.md`): the exact commands to install, run, test, lint/typecheck, **capture screenshots or transcripts** and deploy. Pick verification tooling that works on this machine:
   - **Web:** Playwright, **with a pinned version**: either a dev dependency of the project or a pinned command in the runbook (`npx -y playwright@<version> screenshot …`).
     - Pin the version that `npx -y playwright --version` reports **on this machine now**, not a version from memory.
     - Install the browser for that version with `npx -y playwright@<version> install chromium`. This needs no sudo and is a no-op if it's already installed.
     - Never rely on a floating `npx playwright`. Each release expects a newer browser build, which breaks capture in later sessions.
     - **Prove that one screenshot works now, at any size.** Screenshot a throwaway HTML file and Read the image. If it fails, fix it, or flag it at the Design gate.
     - If system libraries are missing, `sudo npx playwright install-deps chromium` is a user action.
   - **CLI:** scripted sessions whose output is saved as a transcript.
   - **API:** curl or HTTP test scripts.
   - **Mobile or desktop:** state what's possible and what will be ⚠️ manual.
   If there's no way to take screenshots, **say so loudly now** rather than at acceptance.
6. **Roadmap** (`roadmap.md`), ordered by **risk first, then value**:
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
