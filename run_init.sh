#!/bin/bash -x
# BASE IMAGE: any (including unsupported)
# This script tries to automatically detect and init (bootstrap & configure) the host platform.

. prelude.sh

# TODO - move to the config script (resp. run platform independent config scripts from here?)
pushd .git/hooks/ || exit ${EXIT_FILE_IO_ERROR}
ln -s --force ../../pre-commit-hook.sh pre-commit
popd || exit ${EXIT_FILE_IO_ERROR}

mkdir -p Logs

LOG_PATH="../Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOG_PATH

function try_platform
{
    pushd "$1" || exit ${EXIT_FILE_IO_ERROR}

    time ./run_all.sh "$2" 2>&1 | tee "${LOG_PATH}"
    # TODO - consider even better error code number (guaranteed to be unique)
    # exit code 126 = incorrect platform
    local STATUS="${PIPESTATUS[0]}"
    if [[ "${STATUS}" != "${EXIT_INCORRECT_PLATFORM}" ]]; then
        # TODO add success notification?
        # TODO add CommonConfig scripts?
        exit "${STATUS}"
    fi

    popd || exit ${EXIT_FILE_IO_ERROR}
}

try_platform "WSL_Ubuntu_22.04" "$1"
try_platform "WSL_Debian_12" "$1"
try_platform "Ubuntu_22.04" "$1"
try_platform "PopOS_22.04" "$1"
try_platform "Android_13" "$1"

echo -e "${RED}Fatal error: Unsupported platform - no supported platform detected.${NC}"
exit ${EXIT_INCORRECT_PLATFORM}
