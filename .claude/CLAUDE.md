# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Isolated VM-based development environment designed for Claude Code usage. A configurable host directory is mounted into the VM so Claude can work inside the VM while files live on the host machine.

**Tech stack:** Homebrew (host packages), LXD/QEMU/KVM (virtualization), OpenTofu (IaC), Ubuntu minimal (VM OS), Justfile (task runner).

## Key Files

- `INTENT.md` — Single source of truth for project goals and requirements. Only the user edits this file.
- `Brewfile` — Host machine dependencies managed via `brew bundle`
- `claude_config/` — Project-specific Claude configuration (MCP setup, etc.)

## Commands

```bash
# Install host dependencies
brew bundle

# Justfile targets (planned for Milestone 1)
just create    # Create VM
just stop      # Stop VM
just delete    # Delete VM
just enter     # Enter VM shell
```

## Architecture

```
Host (Brewfile, Justfile)
  └── VM (OpenTofu → LXD/QEMU/KVM → Ubuntu minimal)
       ├── Mounted host directory (shared workspace)
       └── Claude Code (native installer)
```

Infrastructure config will live in a dedicated directory separate from `claude_config/`.

## Conventions

- All host dependencies go in `Brewfile`
- Every repetitive operation gets a Justfile target
- VM dependency installation uses a script + package list file (not inline installs)
- Claude Code is installed in the VM via: `curl -fsSL https://claude.ai/install.sh | bash`
