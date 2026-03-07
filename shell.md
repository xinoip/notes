# Shell

These are notes related to all shells and scripts: `bash`, `zsh` etc.

## Script Boilerplate

These stuff fit in nearly every script:

* Stricter error handling
* Working directory independent execution

```bash
#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR SCRIPT_NAME
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

```
