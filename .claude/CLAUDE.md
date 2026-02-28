# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment designed for Claude Code usage. A configurable host directory is mounted into the VM so Claude can work inside the VM while files live on the host machine.

**Tech stack:** Incus/QEMU/KVM (virtualization), OpenTofu (IaC), Ubuntu 24.04 (VM OS), Justfile (task runner), pre-commit + gitleaks (hooks).

## Key Files

- `secrets/` — Contains `.env` and private keys (gitignored except `.env.example`), mounted into VM at `/root/secrets`.
- `secrets/.env.example` — Template for required environment variables (tracked in git).
- `README.md` — Prerequisites and usage instructions.
- `infra/` — OpenTofu configuration for VM provisioning (Incus provider, cloud-init template)
- `infra/tool-versions` — Centralized version pins for host provisioning tools
- `infra/host-cloud-init.yml` — Cloud-init config for host provisioning (Incus, OpenTofu, gh CLI)
- `infra/scripts/gh-setup.sh` — Shared GitHub App auth script (works on host and in VM)
- `infra/scripts/vm-test.sh` — E2E validation script (used by `just vm-test`)

## Commands

```bash
# Authenticate GitHub CLI as the bot app
just gh-setup

# VM lifecycle
just vm-init    # Download OpenTofu providers (once)
just vm-plan    # Preview changes
just vm-up      # Create/update VM
just vm-down    # Destroy VM
just vm-ssh     # Shell into VM as root
just vm-status  # Show VM status
just vm-test    # E2E validation (destroy, create, verify — leaves VM running)
just scan-history  # Scan full git history for leaked secrets (gitleaks)
```

## Architecture

```
Host (Justfile, secrets/)
  └── VM (OpenTofu → Incus/QEMU/KVM → Ubuntu 24.04)
       ├── Host dir mounted at /root/vm_projects (via Incus disk device)
       ├── secrets/ mounted at /root/secrets (live — edits on host reflect in VM)
       ├── Cloud-init runcmd: NodeSource, gh CLI repo, gh-token, uv, Claude Code, oh-my-zsh
       ├── /etc/profile.d/vm-env.sh: PATH, secrets/.env, git identity (all login shells)
       ├── Shell: zsh + oh-my-zsh (default), gh CLI + gh-token on PATH
       └── MCP servers: context7 (npx), mcp-atlassian (uvx), ElevenLabs
```

## Conventions

- Secrets and environment-specific values go in `secrets/.env` (never committed)
- Every repetitive operation gets a Justfile target
- VM provisioning uses cloud-init native modules (packages, apt sources) over shell scripts

## PR and commit hygiene

- Verify latest versions of dependencies (actions, hooks, packages) before writing config files — don't assume remembered versions are current
- Include test evidence (command output) in PR descriptions so reviewers can verify without running locally
- Keep commits scoped to the task — don't bundle unrelated changes into a task branch
- Rebase and merge (not squash) — keep individual commits in main branch history
