# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment for Claude Code. A bare_metal directory is mounted into the workstation VM so Claude can work inside the VM while files live on the bare_metal host.

**Tech stack:** Incus/QEMU/KVM, OpenTofu, Ubuntu 24.04, Justfile, pre-commit.

## Glossary

- **bare_metal** — user's physical machine
- **workstation** — agent workspace VM
- **e2e_test_runner** — validates complete setup of dependencies, scripts, and repeatable workstation provisioning

## Reference Docs

- [`README.md`](README.md) — Setup instructions
- [`docs/style_guide.md`](docs/style_guide.md) — Project-specific style (version pinning, glossary)
- [`docs/file_tree.md`](docs/file_tree.md) — File tree

## Commands

See [`Justfile`](Justfile) for all targets.

## Architecture

```
bare_metal (Justfile, infra/bare_metal/secrets/)
  └── Workstation (OpenTofu → Incus/QEMU/KVM → Ubuntu 24.04)
       ├── bare_metal dir mounted at /root/projects
       ├── infra/bare_metal/secrets/ mounted at /root/secrets
       ├── Cloud-init: packages, write_files, runcmd
       ├── Shell: zsh, oh-my-zsh, Claude Code, gh CLI
       └── MCP: context7, mcp-atlassian, ElevenLabs
```

## Conventions

- Environment-specific values go in `.env` at project root (never committed)
- Every repetitive operation gets a Justfile target
- Workstation provisioning uses cloud-init native modules over scripts
- Versions pinned explicitly — see `docs/style_guide.md`

## PR and commit hygiene

- Verify latest versions of dependencies before writing config files
- Include test evidence in PR descriptions
- Keep commits scoped to the task
- Rebase and merge (not squash)
