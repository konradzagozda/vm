```
.
├── Justfile
├── README.md
├── infra/
│   ├── e2e_test_runner.cloud_init.yml
│   ├── workstation.cloud_init.yml.tftpl
│   ├── envs/
│   │   ├── bare_metal.example.env
│   │   ├── e2e_test_runner.env
│   │   └── workstation.env
│   ├── iac/
│   │   ├── workstation/
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   └── e2e/
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── variables.tf
│   │       └── versions.tf
│   ├── scripts/
│   │   ├── gh_setup.sh                   — GitHub App auth (bare-metal or workstation)
│   │   └── host/
│   │       ├── install_gh_cli.sh
│   │       ├── install_gh_token.sh
│   │       ├── install_opentofu.sh
│   │       └── setup_incus.sh
│   ├── secrets/
│   │   ├── .env.example
│   │   └── key.example.pem
│   └── tests/
│       └── e2e_workstation.sh
```
