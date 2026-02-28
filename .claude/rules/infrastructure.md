---
paths:
  - "infra/**"
---

All infrastructure code lives in the `/infra` directory. Use tools to their fullest potential and avoid scripting until absolutely necessary. Prefer passing information via environment variables over hardcoded values.

## Cloud-init

Use cloud-init to its fullest capabilities — search its [documentation](https://cloudinit.readthedocs.io/) for native modules before writing shell commands. Avoid `runcmd` unless absolutely necessary. Reference scripts from mounted paths rather than embedding content inline.

## Infrastructure as Code

Each resource should have its purpose stated as a comment. Infrastructure components should be organized in directories, preferring file-extension-based modularity over feature-based. When complexity warrants it, nest as `<file_extension>/<feature>`. Pin version constraints explicitly. Use descriptive variable names and always provide a `description` field.
