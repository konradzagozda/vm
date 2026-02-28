# Style Guide

## Comments

Write comments as a single line regardless of length (KAN-22: configure editor line wrap). No multi-line comment blocks for simple explanations. Only comment *why*, not *what* — the code should be self-explanatory.

## Version pinning

Pin all dependency versions explicitly. Centralize pins in `infra/tool-versions` so there is one place to update. Use environment variables (not hardcoded strings) when referencing versions in scripts.

## Scripts

Each tool installation or configuration step should be its own script if no default package manager repository allows installation. Scripts should:

- Start with `#!/usr/bin/env bash` and `set -eu`
- Source `/etc/tool-versions` when they need version variables
- Have a one-line comment describing their purpose

## Cloud-init

Use cloud-init native modules (`packages`, `users`, `groups`, `write_files`) where possible. Use `runcmd` only for operations that have no native module equivalent. Reference scripts from mounted paths rather than embedding content inline.

## Terraform / OpenTofu

Use inline comments sparingly — one line above the block they describe. Avoid trailing comments on resource properties unless they add significant clarity.
