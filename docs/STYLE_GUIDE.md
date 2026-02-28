# Project Style Guide

Project-specific conventions that extend the [general style guide](../.claude/rules/style-guide.md).

## Version pinning

Pin all dependency versions explicitly. Centralize pins in `infra/tool-versions.env` so there is one place to update. Use environment variables (not hardcoded strings) when referencing versions in scripts.

## Naming

Three distinct machine roles in this project:

| Name | Role |
|------|------|
| **bare-metal** | The physical host machine running Incus |
| **workstation** | The dev VM where Claude Code runs |
| **ci-runner** | Ephemeral VM spun up to test the provisioning flow end-to-end |
