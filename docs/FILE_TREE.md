# File Tree

```
.
├── .claude/
│   ├── CLAUDE.md                    — Agent instructions and project context
│   ├── hooks/
│   │   └── claude_log_command.py    — Pre-tool-use hook for command logging
│   ├── settings.json                — Project-level Claude Code settings
│   └── settings.local.json          — Local (gitignored) Claude Code overrides
├── .editorconfig                    — Editor formatting rules
├── .github/
│   ├── PULL_REQUEST_TEMPLATE.md     — PR description template
│   └── workflows/
│       └── pre-commit.yml           — CI workflow for pre-commit hooks
├── .gitignore
├── .mcp.json                        — MCP server configuration
├── .pre-commit-config.yaml          — Pre-commit hook definitions
├── Justfile                         — Task runner targets (VM lifecycle, gh-setup)
├── README.md                        — Prerequisites and usage instructions
├── docs/
│   ├── FILE_TREE.md                 — This file
│   └── STYLE_GUIDE.md              — Code style conventions
├── infra/
│   ├── cloud-init.yml.tftpl         — VM (guest) cloud-init template
│   ├── host-cloud-init.yml          — Host provisioning cloud-init config
│   ├── main.tf                      — Incus VM resource definition
│   ├── outputs.tf                   — Terraform outputs (VM name, IP)
│   ├── scripts/
│   │   ├── gh-setup.sh              — GitHub App authentication (host + VM)
│   │   ├── host/
│   │   │   ├── install-gh-cli.sh    — Install GitHub CLI from precompiled binary
│   │   │   ├── install-gh-token.sh  — Install gh-token standalone binary
│   │   │   ├── install-opentofu.sh  — Install OpenTofu via standalone installer
│   │   │   ├── setup-incus.sh       — Initialize Incus with preseed config
│   │   │   └── setup-zabbly-repo.sh — Add Zabbly apt repo, pin Incus version
│   │   └── vm-test.sh               — E2E validation script (KAN-24: adopt test framework)
│   ├── tool-versions                — Centralized version pins for all tools
│   ├── variables.tf                 — Terraform variable definitions
│   └── versions.tf                  — Terraform provider requirements
└── secrets/
    ├── .env                         — Environment variables (gitignored)
    └── .env.example                 — Template for required env vars (tracked)
```
