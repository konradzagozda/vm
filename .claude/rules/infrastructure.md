---
paths:
  - "infra/**"
---

All infrastructure code lives in the `/infra` directory. **Always look up official documentation before making design decisions** — this is critical for infrastructure where misconfiguration has outsized consequences. Do not assume tool capabilities; verify them.

## Configuration as Code

Use configuration tools to their fullest capabilities — search their documentation for native features before writing custom scripts. Avoid scripting unless absolutely necessary. Reference scripts from mounted paths rather than embedding content inline.

Example tools: cloud-init.

## Infrastructure as Code

Each resource should have its purpose stated as a comment. Infrastructure components should be organized in directories, preferring file-extension-based modularity over feature-based. When complexity warrants it, nest as `<file_extension>/<feature>`. Prefer pinning versions via environment variables using `tool-versions.env`. Use descriptive variable names and always provide a `description` field.
