```
.
├── Justfile
├── README.md
├── infra/
│   ├── bare_metal/
│   │   ├── .env.example              — secrets template
│   │   ├── secrets/                   — runtime secrets (gitignored)
│   │   │   └── gh_app_key.example.pem
│   │   └── tests/
│   │       └── e2e.sh                 — wrapper: creates e2e_test_runner, runs test, destroys
│   ├── common/
│   │   └── scripts/
│   │       ├── gh_setup.sh            — GitHub App auth
│   │       ├── install_gh_cli.sh      — precompiled gh binary
│   │       └── install_gh_token.sh    — gh-token binary
│   ├── e2e_test_runner/
│   │   ├── cloud-init.yml.tftpl       — cloud-init template
│   │   ├── iac/                       — OpenTofu root module
│   │   ├── scripts/
│   │   │   ├── install_opentofu.sh
│   │   │   └── setup_incus.sh
│   │   ├── tests/
│   │   │   └── workstation_setup.sh   — creates workstation, validates, destroys
│   │   └── tools.env                  — pinned versions
│   └── workstation/
│       ├── cloud-init.yml.tftpl       — cloud-init template
│       ├── iac/                       — OpenTofu root module
│       ├── scripts/
│       │   ├── install_claude_code.sh
│       │   ├── install_nodejs.sh
│       │   ├── install_ohmyzsh.sh
│       │   ├── install_uv.sh
│       │   ├── setup_mcp.sh
│       │   └── setup_shell.sh
│       └── tools.env                  — pinned versions
```
