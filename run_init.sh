#!/bin/bash -x
# Automatically detect and init/configure the host platform.

. prelude.sh

if [ "$1" = "--help" ]; then
    echo "usage: ./run_all.sh [--noninteractive]"
    echo
    # shellcheck disable=SC2016
    echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
    exit "${EXIT_SUCCESS}"
elif [ "$1" == "--noninteractive" ]; then
    export NONINTERACTIVE='true'
    echo 'NONINTERACTIVE=true'
elif [ "$1" == "" ]; then
    echo "Interactive part of the script will be executed..."
else
    echo "Invalid argument $1"
    exit "${EXIT_INVALID_ARGUMENT}"
fi

LOGFILE="$(pwd)/Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOGFILE
mkdir -p "$(dirname "${LOGFILE}")"

# Redirect all output (stdout + stderr) to both the log file and the terminal
exec > >(tee -i "$LOGFILE") 2>&1

function try_platform
{
    pushd "$1" || exit "${EXIT_FILE_IO_ERROR}"
    . ./run_all.sh
    popd || exit "${EXIT_FILE_IO_ERROR}"
}

# TODO set timezone before running anything...
# TODO fix
# see: https://linuxize.com/post/how-to-set-or-change-timezone-on-debian-10/
# see: https://chatgpt.com/share/e001132e-2bfc-4b68-ab99-8697da44ccc2
# timedatectl set-timezone Europe/Vienna
# TODO rationalize parameter passing
try_platform "CLI_Ubuntu"
# try_platform "DebianCLI"
# try_platform "KaliCLI"
try_platform "Ubuntu"
# try_platform "PopOS_22.04"
try_platform "Android_13"

# TODO print executed var (it will be a list of all subscripts that were executed)
# and some succesfull execution msg.
