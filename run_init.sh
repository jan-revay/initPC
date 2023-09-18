#!/bin/bash -x
# BASE IMAGE: any (including unsupported)
# This script tries to automatically detect and init/configure the host platform.

# TODO consider logging errors to STDERR?

. prelude.sh

LOG_PATH="$(pwd)/Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOG_PATH
mkdir -p "$(dirname "${LOG_PATH}")"

function try_platform
{
    pushd "$1" || exit ${EXIT_FILE_IO_ERROR}

    time ./run_all.sh "$2" 2>&1 | tee "${LOG_PATH}"
    local STATUS="${PIPESTATUS[0]}"

    if [[ "${STATUS}" == "0" ]]; then
        echo -e "${GREEN}run_init.sh: All configuration scripts run successfully.${NC}" \
            | tee --append "${LOG_PATH}"
    else
        echo -e "${RED}run_init.sh: Error - exit code ${STATUS}${NC}" \
            | tee --append "${LOG_PATH}"
    fi

    if [[ "${STATUS}" != "${EXIT_INCORRECT_PLATFORM}" ]]; then
        exit "${STATUS}"
    fi

    popd || exit ${EXIT_FILE_IO_ERROR}
}

# TODO rationalize parameter passing
try_platform "WSL_Ubuntu_22.04" "$1"
try_platform "WSL_Debian_12" "$1"
try_platform "Ubuntu_22.04" "$1"
try_platform "PopOS_22.04" "$1"
try_platform "Android_13" "$1"

echo -e "${RED}run_init.sh: Fatal error - Unsupported platform " \
    "- no supported platform detected.${NC}" \
    | tee --append "${LOG_PATH}"
exit ${EXIT_INCORRECT_PLATFORM}
