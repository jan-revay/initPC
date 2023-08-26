#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# This script tries to detect platform automatically

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"

function try_platform
{
    cd "$1" || exit
    # shellcheck disable=SC1091
    ./run_all.sh 2>&1 | tee ../Logs/"$(date "+%Y%m%d_%H%M%S")".log
    cd ..
}

try_platform "WSL_Ubuntu_22.04"
try_platform "WSL_Debian_12"
try_platform "Ubuntu_22.04"
try_platform "PopOS_22.04"
try_platform "Android_13"
