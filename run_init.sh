#!/bin/bash -x
# BASE IMAGE: any (including unsupported)
# This script tries to automatically detect and init/configure the host platform.

# TODO consider logging errors to STDERR?

. prelude.sh

# TODO improve parameter parsing - move it to platform-independent code
if [ "$1" = "--help" ]; then
    echo "usage: ./run_all.sh [--noninteractive]"
    echo
    # shellcheck disable=SC2016
    echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
    exit "${EXIT_SUCCESS}"
elif [ "$1" == "--noninteractive" ]; then
    readonly NONINTERACTIVE='true'
    echo 'NONINTERACTIVE=true'
elif [ "$1" == "" ]; then
    echo "Interactive part of the script will be executed at the end..."
else
    echo "Invalid argument $1"
    exit "${EXIT_INVALID_ARGUMENT}"
fi

LOG_PATH="$(pwd)/Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOG_PATH
mkdir -p "$(dirname "${LOG_PATH}")"

function try_platform
{
    pushd "$1" || exit "${EXIT_FILE_IO_ERROR}"

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

    popd || exit "${EXIT_FILE_IO_ERROR}"
}

# TODO set timezone before running anything...
# TODO fix
# see: https://linuxize.com/post/how-to-set-or-change-timezone-on-debian-10/
# see: https://chatgpt.com/share/e001132e-2bfc-4b68-ab99-8697da44ccc2
# timedatectl set-timezone Europe/Vienna
# TODO rationalize parameter passing
try_platform "UbuntuCLI" "$1"
try_platform "DebianCLI" "$1"
try_platform "KaliCLI" "$1"
try_platform "Ubuntu_22.04" "$1"
try_platform "PopOS_22.04" "$1"
try_platform "Android_13" "$1"

echo -e "${RED}run_init.sh: Fatal error - Unsupported platform " \
    "- no supported platform detected.${NC}" \
    | tee --append "${LOG_PATH}"
exit "${EXIT_INCORRECT_PLATFORM}"
