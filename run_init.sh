#!/bin/bash -x
# BASE IMAGE: any (including unsupported)
# This script tries to automatically detect and init (bootstrap & configure) the host platform.

# TODO add this (including color vars to prelude script)
# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

RED='\033[0;31m'
NC='\033[0m' # No Color

# TODO - move to the config script (resp. run platform independent config scripts from here?)
pushd .git/hooks/ || exit 50
ln -s --force ../../pre-commit-hook.sh pre-commit
popd || exit 50

mkdir -p Logs

LOG_PATH="../Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOG_PATH

function try_platform
{
    pushd "$1" || exit 50

    time ./run_all.sh "$2" 2>&1 | tee "${LOG_PATH}"
    # TODO - consider even better error code number (guaranteed to be unique)
    # exit code 126 = incorrect platform
    if [[ "${PIPESTATUS[0]}" != 126 ]]; then
        exit "${PIPESTATUS[0]}"
    fi

    popd || exit 50
}

try_platform "WSL_Ubuntu_22.04" "$1"
try_platform "WSL_Debian_12" "$1"
try_platform "Ubuntu_22.04" "$1"
try_platform "PopOS_22.04" "$1"
try_platform "Android_13" "$1"

echo -e "${RED}Fatal error: Unsupported platform - no supported platform detected.${NC}"
exit 60
