# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment designed for Claude Code usage. A configurable bare-metal directory is mounted into the workstation VM so Claude can work inside the VM while files live on the bare-metal host.

**Tech stack:** Incus/QEMU/KVM (virtualization), OpenTofu (IaC), Ubuntu 24.04 (VM OS), Justfile (task runner), pre-commit (hooks).

## Naming

| Name | Role |
|------|------|
| **bare-metal** | Physical host machine running Incus |
| **workstation** | Dev VM where Claude Code runs |
| **ci-runner** | Ephemeral VM for testing the provisioning flow end-to-end |

## Reference Docs

- [`README.md`](README.md) — Project purpose and setup instructions
- [`.claude/rules/`](.claude/rules/) — Code style rules (auto-matched by file pattern)
- [`docs/STYLE_GUIDE.md`](docs/STYLE_GUIDE.md) — Project-specific style (version pinning, naming)
- [`docs/FILE_TREE.md`](docs/FILE_TREE.md) — Annotated file tree

## Commands

```bash
just gh-setup   # Authenticate GitHub CLI as the bot app
just vm-init    # Download OpenTofu providers (once)
just vm-plan    # Preview changes
just vm-up      # Create/update workstation VM
just vm-down    # Destroy workstation VM
just vm-ssh     # Shell into workstation as root
just vm-status  # Show workstation status
just vm-test    # E2E validation (create, verify, destroy)
```

## Architecture

```
Bare-metal (Justfile, secrets/)
  └── Workstation VM (OpenTofu → Incus/QEMU/KVM → Ubuntu 24.04)
       ├── Bare-metal dir mounted at /root/projects (via Incus disk device)
       ├── secrets/ mounted at /root/secrets (live — edits on bare-metal reflect in VM)
       ├── Cloud-init: packages, write_files, runcmd
       ├── Shell: zsh + oh-my-zsh, Claude Code on PATH, gh CLI installed
       └── MCP servers: context7 (npx), mcp-atlassian (uvx), ElevenLabs
```

## Conventions

- Secrets and environment-specific values go in `secrets/.env` (never committed)
- Every repetitive operation gets a Justfile target
- Workstation provisioning uses cloud-init native modules over shell scripts
- Versions are pinned explicitly — see `docs/STYLE_GUIDE.md`

## PR and commit hygiene

- Verify latest versions of dependencies (actions, hooks, packages) before writing config files — don't assume remembered versions are current
- Include test evidence (command output) in PR descriptions so reviewers can verify without running locally
- Keep commits scoped to the task — don't bundle unrelated changes into a task branch
- Rebase and merge (not squash) — keep individual commits in main branch history
