#!/bin/bash -x
# TODO precommit hooks WIP

# makes the echo prompt yellow to improve readability

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

set -e # exit on error

find . -type f -name "*.sh" | xargs -I{} shfmt -w {}
find . -type f -name "*.sh" \
    | xargs -I{} bash -c \
        'cd $(dirname {}) && echo "### Entering directory: $(dirname {})" && shellcheck $(basename {})'
