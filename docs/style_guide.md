## Version pinning

Pin all dependency versions explicitly. Centralize pins in `infra/<target>/tools.env`. Use environment variables (not hardcoded strings) when referencing versions in scripts.

## Glossary

- **bare_metal** — user's physical machine
- **workstation** — agent workspace VM
- **e2e_test_runner** — validates complete setup of dependencies, scripts, and repeatable workstation provisioning
