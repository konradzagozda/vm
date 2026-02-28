# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment designed for Claude Code usage. A configurable host directory is mounted into the VM so Claude can work inside the VM while files live on the host machine.

**Tech stack:** Incus/QEMU/KVM (virtualization), OpenTofu (IaC), Ubuntu 24.04 (VM OS), Justfile (task runner), pre-commit (hooks).

## Reference Docs

- [`docs/STYLE_GUIDE.md`](../docs/STYLE_GUIDE.md) — Code style conventions (comments, version pinning, scripts, cloud-init, Terraform)
- [`docs/FILE_TREE.md`](../docs/FILE_TREE.md) — Annotated file tree with purpose of each file

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
just vm-test    # E2E validation (create, verify, destroy)
```

## Architecture

```
Host (Justfile, secrets/)
  └── VM (OpenTofu → Incus/QEMU/KVM → Ubuntu 24.04)
       ├── Host dir mounted at /root/projects (via Incus disk device)
       ├── secrets/ mounted at /root/secrets (live — edits on host reflect in VM)
       ├── Cloud-init native modules: packages, apt sources, write_files, runcmd
       ├── Shell: zsh + oh-my-zsh, Claude Code on PATH, gh CLI installed
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
