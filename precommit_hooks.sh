#!/bin/bash -x
# TODO precommit hooks WIP

# makes the echo prompt yellow to improve readability

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

set -e # exit on error

find . -type f -name "*.sh" -execdir shfmt -w {} \;

# TODO compare consider this alterantive way or remove
# find . -type f -name "*.sh" -print0 \
#     | xargs -0 -I{} bash -c \
#         'cd $(dirname {}) && echo "### Entering directory: $(dirname {})" && shellcheck $(basename {})'
#

# TODO why `find ... -execdir ... {} +` does not work here?
# I am passing the filename as a parameter to the bash subshell
find . -type f -name "*.sh" -execdir \
    bash -c 'echo "### Entering directory $(pwd)" && shellcheck "${1}"' bash {} \;
