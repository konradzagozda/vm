# File Tree

```
.
├── CLAUDE.md                            — Agent instructions and project context
├── Justfile                             — Task runner targets (VM lifecycle, gh-setup)
├── README.md                            — Project purpose and setup instructions
├── docs/
│   ├── FILE_TREE.md                     — This file
│   └── STYLE_GUIDE.md                  — Project-specific style conventions
├── infra/
│   ├── cloud-init.yml.tftpl             — Workstation cloud-init template
│   ├── host-cloud-init.yml              — Ci-runner provisioning cloud-init config
│   ├── scripts/
│   │   ├── gh-setup.sh                  — GitHub App authentication (bare-metal + workstation)
│   │   ├── host/
│   │   │   ├── install-gh-cli.sh        — Install GitHub CLI from precompiled binary
│   │   │   ├── install-gh-token.sh      — Install gh-token standalone binary
│   │   │   ├── install-opentofu.sh      — Install OpenTofu via standalone installer
│   │   │   ├── setup-incus.sh           — Initialize Incus with preseed config
│   │   │   └── setup-zabbly-repo.sh     — Add Zabbly apt repo, pin Incus version
│   │   └── vm-test.sh                   — E2E validation script (KAN-24: adopt test framework)
│   ├── tf/
│   │   ├── main.tf                      — Incus workstation VM resource definition
│   │   ├── outputs.tf                   — Terraform outputs (VM name, IP)
│   │   ├── variables.tf                 — Terraform variable definitions
│   │   └── versions.tf                  — Terraform provider requirements
│   └── tool-versions.env                — Centralized version pins for all tools
└── secrets/
    ├── .env                             — Environment variables (gitignored)
    └── .env.example                     — Template for required env vars (tracked)
```
