# Phase 6: Deployment

**Purpose:** deliver the system to where its users are. That covers the logistics of release and the environment, configuration and data, user docs and training, and handing future work over to whoever maintains it.

**Inputs:** the final acceptance report, architecture.md (deployment target) and runbook.md.
**Outputs:** the deployed system, a complete runbook (operate, roll back, troubleshoot), user docs and the handover notes in `runbook.md`.

## The cycle in this phase

**Plan.** Write a deployment plan in `runbook.md` under "Release":
- the target and environments;
- configuration and secrets, with where each lives;
- data migration or seeding;
- the release steps in order;
- the **rollback** steps;
- the smoke test;
- monitoring and alerting, scaled to the project;
- cost;
- who operates the system afterwards.

**Challenge.** Look for:
- a rollback that has never been tested;
- secrets in the repo or in logs;
- an irreversible migration with no backup;
- missing environment parity (it worked locally because…);
- cost surprises;
- missing user docs.

**Gate before acting.** Production deploys, publishing, DNS changes, creating paid resources and sending anything to external services are outward-facing and often irreversible. Present the plan and get explicit approval (**Go-live gate**) before doing any of them. Staging and preview deploys follow whatever the design gate already approved.

**Implement.**
- Pipeline or deploy scripts, production config, `.env.example` and a migration script with a backup step.
- User docs: README usage, a help page or manual, and, if users need training, a short getting-started guide.
- Handover notes: how to run, debug, release and extend the system, kept in `runbook.md` so a new agent or person can operate it from that file alone.

**Verify.**
- Deploy following the runbook, exactly as written. If you had to improvise a step, the runbook is wrong, so fix it.
- **Smoke test the live system:** walk the core journeys, take screenshots and save them to `evidence/release/`.
- Test the rollback if it's safe (for example on staging, or with a no-op version). If it isn't safe, mark it ⚠️ untested at the gate.

**Update.**
- Record the release (version, date, URL) in STATE.md and `decisions.md`, and tag it with `git tag vX.Y.Z`. Don't push without asking.
- Commit, then report go-live with the smoke-test evidence. The phase becomes `7 Evolve`.

## Exit criteria
- The system is live (or packaged and delivered), and the smoke test is ✅.
- The rollback is documented and tested or flagged.
- The user docs and handover notes are done.
- The user has approved at the **Go-live gate**, both before and after the release.
