---
paths:
  - "**/*.sh"
---

Every script starts with `#!/usr/bin/env bash` and `set -euox pipefail`.

Use environment variables over args and opts.

## Doc

Every script has a top-level block comment:

1. Purpose
2. Example — exactly one, more beneath Usage
3. Environment — required and optional vars
4. Usage — flags, options

```bash
#!/usr/bin/env bash
set -euox pipefail

/*
 * Install GitHub CLI from precompiled binaries.
 *
 * Example:
 *   ./install-gh-cli.sh
 *
 * Environment:
 *   GH_CLI_VERSION — required, from /etc/tool-versions.env
 *
 * Usage:
 *   ./install-gh-cli.sh
 */
```
