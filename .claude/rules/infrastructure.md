---
paths:
  - "infra/**"
---

All infrastructure code lives in `/infra`. **Always consult official documentation before design decisions** — misconfiguration has outsized consequences.

Use explicit configuration over relying on defaults.

## Configuration as Code

Exhaust native features of configuration tools before writing scripts. Avoid scripting unless absolutely necessary. Reference scripts from mounted paths, not inline content.

e.g. cloud-init.

## Infrastructure as Code

Modularize by file-extension over feature. Pin versions via envs in a dedicated file. Use self-descriptive names.
