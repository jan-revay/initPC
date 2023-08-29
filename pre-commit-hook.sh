#!/bin/bash -x
# TODO precommit hooks WIP

# makes the echo prompt yellow to improve readability

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

set -e # exit on error

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo
echo -e "${GREEN} ######  RUNNING PRE-COMMIT HOOKS  ###### ${NC}"
echo

find . -type f -name "*.sh" -execdir shfmt -w {} \;

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
