# Style Guide

## Comments

/*
 * Use block comment syntax for multi-line explanations.
 * Prefer this over repeating single-line comment markers.
 */

For single-line comments, use the language's standard single-line syntax. Only comment *why*, not *what* — the code should be self-explanatory. Ensure your editor has line wrap enabled (KAN-22).

## Scripts

Each tool installation or configuration step should be its own script if no default package manager repository allows installation. Scripts should:

- Start with `#!/usr/bin/env bash` and `set -eu`
- Source the tool-versions.env file when they need version variables
- Have a one-line comment describing their purpose

## Cloud-init

Use cloud-init to its full capabilities — prefer native modules (`packages`, `users`, `groups`, `write_files`, `apt`, `snap`, `timezone`, `locale`, `ntp`) over shell commands. Use `runcmd` only for operations that have no native module equivalent. Reference scripts from mounted paths rather than embedding content inline.
