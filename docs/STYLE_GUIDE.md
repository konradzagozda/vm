## Version pinning

Pin all dependency versions explicitly. Centralize pins in `infra/envs/` env files. Use environment variables (not hardcoded strings) when referencing versions in scripts.

## Glossary

- **bare-metal** — User's physical machine
- **workstation** — Agent workspace VM
- **e2e_test_runner** — Validates complete setup of dependencies, scripts, and repeatable workstation provisioning
