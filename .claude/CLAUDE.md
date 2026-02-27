# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment designed for Claude Code usage. A configurable host directory is mounted into the VM so Claude can work inside the VM while files live on the host machine.

**Tech stack:** LXD/QEMU/KVM (virtualization), OpenTofu (IaC), Ubuntu minimal (VM OS), Justfile (task runner).

## Key Files

- `INTENT.md` — Single source of truth for project goals and requirements. Only the user edits this file.
- `.env` / `.env.example` — Environment variables (secrets, app IDs). `.env` is gitignored.
- `README.md` — Manual steps for loading env vars and launching Claude.
- `claude_config/` — Project-specific Claude configuration (MCP setup, etc.)

## Commands

```bash
# Load environment variables (must be done before other commands)
set -a && source .env && set +a

# Authenticate GitHub CLI as the bot app
just gh-setup

# Launch Claude Code
claude
```

## Architecture

```
Host (Justfile, .env)
  └── VM (OpenTofu → LXD/QEMU/KVM → Ubuntu minimal)
       ├── Mounted host directory (shared workspace)
       └── Claude Code (native installer)
```

Infrastructure config will live in a dedicated directory separate from `claude_config/`.

## Conventions

- Secrets and environment-specific values go in `.env` (never committed)
- Every repetitive operation gets a Justfile target
- VM dependency installation uses a script + package list file (not inline installs)
- Claude Code is installed in the VM via: `curl -fsSL https://claude.ai/install.sh | bash`

## PR and commit hygiene

- Verify latest versions of dependencies (actions, hooks, packages) before writing config files — don't assume remembered versions are current
- Include test evidence (command output) in PR descriptions so reviewers can verify without running locally
- Keep commits scoped to the task — don't bundle unrelated changes into a task branch
- Squash fix-up commits before merging so the main branch history stays clean
