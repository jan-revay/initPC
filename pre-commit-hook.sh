#!/bin/bash
. prelude.sh
# TODO precommit hooks WIP

# TODO always run from repo root directory regardless of the pwd

echo
echo -e "${GREEN} ######  RUNNING PRE-COMMIT HOOKS  ###### ${NC}"

files=$(find . -type f -name "*.sh" -exec shfmt -l {} \;)
if [ -n "$files" ]; then
    err "Error: The following shell files need formatting:"
    err "$files"
    err
    err "Running: find . -type f -name \"*.sh\" -exec shfmt -w {} \\;"
    find . -type f -name "*.sh" -execdir shfmt -w {} \;
    err "git add the formatted files and commit again"
    exit 1
fi

# NOTE: `find -execdir` cannot be used because it does not propagate errors
# NOTE: I am passing the filename as a parameter to the bash subshell, see
# https://www.shellcheck.net/wiki/SC2156 for more info
# shellcheck disable=SC2016
find . -type f -name "*.sh" -print0 \
    | xargs -0 -I{} bash -c \
        'cd $(dirname "$1") &&
        echo "### Entering directory: $(dirname "$1")" &&
        shellcheck $(basename "$1")' bash {}

# WARNING: `find -execdir` cannot be used - TODO delete
# TODO why `find ... -execdir ... {} +` does not work here?
# I am passing the filename as a parameter to the bash subshell
# find . -type f -name "*.sh" -execdir \
#     bash -c 'echo "### Entering directory $(pwd)" && shellcheck "${1}"' bash {} \;
#

find . -type f -name '*.sh' \( \
    ! -name "prelude.sh" \
    \) -print0 \
    | while IFS= read -r -d '' f; do
        if ! sed -n '2p' "$f" \
            | grep -Eq '^\.[[:space:]]+(\.\./)*prelude\.sh$'; then
            err "File does not have . prelude.sh on the 2nd line: $f"
            err "Running prelude_rearrange.sh"
            ./StaticAnalysis/prelude_rearrange.sh
            exit 2
        fi
    done
