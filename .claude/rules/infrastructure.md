---
paths:
  - "infra/**"
---

All infrastructure code lives in `/infra`. **Always consult official documentation before design decisions** — misconfiguration has outsized consequences.

Prefer explicit configuration over relying on defaults.

## Configuration as Code

Exhaust native features of configuration tools before writing scripts. Avoid scripting unless absolutely necessary. Reference scripts from mounted paths, not inline content.

e.g. cloud-init.

## Infrastructure as Code

Organize in directories: prefer file-extension-based modularity over feature-based. Nest as `<extension>/<feature>` when warranted. Pin versions via environment variables using `tool-versions.env`. Use self-descriptive names with `description` fields.
