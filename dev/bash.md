# Bash Scripting

Scripting tads and bits for Bash.

## Best Practices

These are the best practices I have found useful while writing Bash scripts. It
all boils down to following boilerplate:

```bash
#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
  # script logic here
}

main "$@"
cd "$OLD_PWD"
```

### Separate Declaration from Assignment

Declarations and assignments return status codes. Declarations tend to always
return success, masking the return code of the assignment. Solution is to
separate them.

```bash
# Bad
readonly VAR_ONE="$(...)"
readonly VAR_TWO="$(...)"

# Good
VAR_ONE="$(...)"
VAR_TWO="$(...)"
readonly VAR_ONE VAR_TWO

# Still Good
readonly VAR_THREE="something-constant"
```

### Normalize Working Directory

Scripts should correctly work however they are invoked. This means that you have
to normalize the working directory or always use absolute paths. The latter is
cumbersome. Solution is to normalize the working directory at the start of the
script.

```bash
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
```

It should also recover the original working directory at the end of the script.

```bash
OLD_PWD="$PWD"
# ...
cd "$OLD_PWD"
```

Another solution is to store the original working directory in a variable and
use it for all path involving operations. I don't like this solution because it
makes the script too verbose.

```bash
SCRIPT_DIR="$(cd "$(dirname $(realpath "${BASH_SOURCE[0]}"))" && pwd)"
# Prefix all path with $SCRIPT_DIR
```

### `${BASH_SOURCE[0]}` vs `$0`

`${BASH_SOURCE[0]}` is always the path to the current script itself. It supports
sourcing the script from another script. `$0` tends to be the path to the
script, but if the script is sourced, its value is set to shell name like
`bash`. Prefer `${BASH_SOURCE[0]}` over `$0`.

### `$PWD` vs `$(pwd)`

Former is the builtin variable and latter is a command invocation. Prefer the
former over the latter.

### Enable Bash Strict Mode

This is basically a strict mode for Bash.

```bash
set -euo pipefail
```

- `-e`: Exit immediately if a command fails.
- `-u`: Treat unset variables as errors.
- `-o pipefail`: Exit if any command in a pipeline fails.

### Best Shebang

It is `#!/usr/bin/env bash`. It basically asks the system where `bash`
executable is and uses that.

### Local and Readonly Variables

Use `local -r` to declare a variable that is local and read only.

For variables that has command substitution, you have to do some ugly things:

```bash
local MY_VAR
MY_VAR="$(...)"
readonly MY_VAR
```
