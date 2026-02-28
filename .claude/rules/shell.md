---
paths:
  - "**/*.sh"
---

Every script starts with `#!/usr/bin/env bash`, `set -euo pipefail`, and `set -x` on the next line.

Use environment variables over args and opts.

## Docblock

Every script has a top-level block comment:

1. Purpose
2. Example — exactly one invocation, more beneath Usage
3. Environment — required and optional vars
4. Usage — flags, options

```bash
#!/usr/bin/env bash
set -euo pipefail
set -x

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
