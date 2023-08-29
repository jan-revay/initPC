#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# This script tries to detect platform automatically

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"

mkdir -p Logs

LOG_PATH="../Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOG_PATH # the file should be rewritten

function try_platform
{
    cd "$1" || exit 50

    time ./run_all.sh 2>&1 | tee "${LOG_PATH}"
    # TODO - consider even better error code number (guaranteed to be unique)
    # exit code 126 = incorrect platform
    if [[ "${PIPESTATUS[0]}" != 126 ]]; then
        exit 0
    fi

    cd ..
}

try_platform "WSL_Ubuntu_22.04"
try_platform "WSL_Debian_12"
try_platform "Ubuntu_22.04"
try_platform "PopOS_22.04"
try_platform "Android_13"
