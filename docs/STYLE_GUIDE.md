## Version pinning

Pin all dependency versions explicitly. Centralize pins in `infra/tools/` env files. Use environment variables (not hardcoded strings) when referencing versions in scripts.

## Glossary

| Name | Role |
|------|------|
| **bare-metal** | User's physical machine |
| **workstation** | Agent workspace VM |
| **e2e-validator** | Validates complete setup of dependencies, scripts, and repeatable workstation provisioning |
