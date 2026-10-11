# <Product>: Runbook
<!-- Created in phase 3 and proven in M1: every command here has actually been run. Completed in phase 6. Write commands, not prose. -->
Status: draft | proven in M1 | released
Updated: YYYY-MM-DD · Hub: [STATE.md](STATE.md)

## Setup
```bash
<install dependencies>
```

## Run (dev)
```bash
<start command>   # serves on http://localhost:<port>
```

## Test
```bash
<unit + integration>
<e2e / acceptance>
<lint>; <typecheck>; <build>
```

## Capture evidence
```bash
<screenshot command, e.g. npx playwright screenshot http://localhost:<port>/<path> docs/sdlc/evidence/M<n>/<name>.png>
<or a CLI transcript: ./app <args> 2>&1 | tee docs/sdlc/evidence/M<n>/<name>.txt>
```
Limitations: <anything that can't be captured here and must be ⚠️ manual>

## Release
- Target: <…> · Environments: <…>
- Config and secrets: <name → where it lives> (template: `.env.example`)
```bash
<deploy steps, in order>
```
- Smoke test: <journeys to walk, URL>
- Rollback:
```bash
<rollback steps>
```

## Operate and handover
- Logs: <where> · Health: <URL or command>
- Common problems: <symptom → fix>
- Extending: <where new features go, and conventions to follow>
