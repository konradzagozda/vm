```
.
├── Justfile
├── README.md
├── infra/
│   ├── e2e-validator.cloud-init.yml
│   ├── workstation.cloud-init.yml.tftpl
│   ├── iac/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── scripts/
│   │   ├── gh-setup.sh                 — GitHub App auth (bare-metal or workstation)
│   │   └── host/
│   │       ├── install-gh-cli.sh
│   │       ├── install-gh-token.sh
│   │       ├── install-opentofu.sh
│   │       └── setup-incus.sh
│   ├── tests/
│   │   └── e2e-workstation.sh
│   └── tools/
│       ├── bare-metal.env
│       └── workstation.env
└── envs/
    └── .env.example
```
