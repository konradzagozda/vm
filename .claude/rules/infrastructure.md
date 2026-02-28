---
paths:
  - "infra/**"
---

## General

Use tools to their fullest potential and avoid scripting until absolutely necessary. Prefer passing information via environment variables over hardcoded values.

## Cloud-init

From the [cloud-init docs](https://cloudinit.readthedocs.io/):

> Cloud-init is the industry standard multi-distribution method for cross-platform cloud instance initialisation.

Exhaust cloud-init's native modules (`packages`, `users`, `groups`, `write_files`, `apt`, `snap`, `timezone`, `locale`, `ntp`, `ssh`, `mounts`) before falling back to `runcmd`. Reference scripts from mounted paths rather than embedding content inline.

## Shell scripts

Each tool installation or configuration step should be its own script if no default package manager repository allows installation.

## Terraform / OpenTofu

Use single-line comments (`#`) for brief annotations above resource blocks. For longer explanations, use block comments:

```hcl
/*
 * Multi-line explanation goes here.
 * Describe the why, not the what.
 */
```

Avoid trailing comments on resource properties unless they add significant clarity.

Place all `.tf` files in a dedicated subdirectory (e.g. `infra/tf/`), separate from cloud-init configs and scripts. Pin version constraints explicitly in `versions.tf`. Use descriptive variable names and always provide a `description` field.
