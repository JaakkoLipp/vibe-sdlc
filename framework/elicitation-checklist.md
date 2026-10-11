# Elicitation checklist

Use this as a menu, not a script. Pick the categories that apply to the request, skip the rest, and within each one ask only what the code and the conversation haven't already answered. Every category notes what to look up yourself before you ask.

## 1. Goal and context
- What problem does this solve, and for whom? What do they do today instead?
- Why now? Is there a deadline, an event or a dependency driving it?
- What does success look like: a metric, a demo, or a workflow that becomes possible?
- *Look up first:* README, issues and TODOs, how similar features in the repo are framed.

## 2. Users and actors
- Who are the user types (roles, technical level)? Which one matters most?
- Which other systems call this, or get called by it?
- How many users or how much traffic? An order of magnitude is enough.
- *Look up first:* existing roles and permission models, API clients.

## 3. Scope
- What's the smallest version that would be useful (the MVP)?
- What's explicitly out of scope for now? Write it down so it doesn't creep back in.
- Is this one milestone or several?

## 4. Functional behaviour
- Walk through the main flow step by step: trigger, then input, then processing, then output.
- What are the inputs (format, source, validation rules) and the outputs (format, destination)?
- What are the variations: optional steps, modes, settings?
- What state does it keep, and how does that state change?

## 5. Unhappy paths and edge cases
- Invalid or missing input: reject it, coerce it, or warn?
- Partial failure: retry, roll back, or leave a partial result? Is the operation idempotent?
- Empty states, a first run, very large inputs, limits and quotas.
- Concurrency: two users or processes act at once. Which one wins?
- External dependency down or slow: what does the user see?

## 6. Data
- Where does the data live? Is it a new store or an existing one?
- What is its shape, and what are the key entities and relationships?
- Does existing data need migrating or backfilling?
- Retention, deletion, export.
- Sensitive data (PII, secrets, payment details): storage and masking rules.
- *Look up first:* the schema, models, migrations, ORM conventions.

## 7. Interfaces
- UI: which screens or components, any existing design system, which states need to be shown.
- API: style (REST, GraphQL, RPC), versioning, error format, pagination.
- CLI: commands, flags, exit codes, output format (human-readable vs JSON).
- Files and integrations: formats, encodings, third-party APIs.
- *Look up first:* existing endpoints, components and CLI patterns to stay consistent with.

## 8. Security and permissions
- Who may perform each action? How do they authenticate?
- What must be audited or logged?
- Threats worth naming: injection, abuse, rate limiting, data leakage between tenants.
- *Look up first:* the existing auth middleware and permission checks.

## 9. Quality attributes (non-functional)
Turn each of these into a number or an observable behaviour, never just "fast".
- Performance: latency or throughput targets, data sizes.
- Reliability: what's acceptable when things fail, and recovery expectations.
- Compatibility: supported platforms, browsers, runtime versions, backward compatibility for current callers.
- Accessibility and i18n: languages, locales, a11y standard.
- Observability: logs, metrics, alerts that someone will actually read.

## 10. Constraints
- Technology that's mandated or forbidden (languages, libraries, services, licences).
- Budget, hosting, time box.
- Organisational constraints: reviews, compliance, who owns what.
- *Look up first:* the manifest files, CI config, lint and format settings.

## 11. Verification and rollout
- How will each requirement be tested: unit, integration, end-to-end, or manual?
- What will the user check personally before calling it done?
- Rollout: feature flag, migration order, rollback plan.
- Documentation that needs updating.

## Question patterns that work

- **Forced choice with a recommendation:** "Should invalid rows be (a) skipped and reported *(recommended: keeps big imports moving)*, (b) fixed automatically, or (c) cause the whole import to fail?"
- **Concrete scenario:** "Alice edits a record while Bob deletes it. What should Alice see?"
- **Boundary probe:** "What's the biggest file anyone would realistically upload? 10 MB, 1 GB?"
- **Negative space:** "What would make this a failure even if it technically works?"
- **Priority squeeze:** "If only one of X and Y ships this week, which one?"

## Anti-patterns

- Asking things the repo already answers (which framework, the test runner, code style).
- Leading questions that are really announcements ("We'll use Postgres, right?"). If you've decided, state it as an assumption.
- Compound questions ("Should it support CSV and JSON, and should exports be async?"). Split them.
- Vague prompts ("Any other requirements?") instead of a concrete probe.
- Asking about implementation details the user doesn't care about. Decide those yourself and record them in the plan.
