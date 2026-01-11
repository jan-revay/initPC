#!/bin/bash
. prelude.sh
# Automatically detect and init/configure the host platform.

# TODO consider cd ing to script repo here so that the script can be run from
# anywhere, see .my_scripts/WB.sh
# TODO consider renaming run_init.sh to main.sh

if [[ $# == 0 ]]; then
    echo "No parameters set, the interactive part of the script will be executed..."
    export NONINTERACTIVE='false'
elif [[ $# -gt 1 ]]; then
    echo "ERROR: Too many parameters. See --help."
    exit "${EXIT_INVALID_ARGUMENT}"
else
    if [[ "$1" == "--help" ]]; then
        echo "usage: ./run_all.sh [--noninteractive]"
        echo
        # shellcheck disable=SC2016
        echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
        exit "${EXIT_SUCCESS}"
    elif [[ "$1" == "--noninteractive" ]]; then
        export NONINTERACTIVE='true'
        echo 'set NONINTERACTIVE=true'
    else
        echo "Invalid argument \"$1\""
        exit "${EXIT_INVALID_ARGUMENT}"
    fi
fi

LOGFILE="$(pwd)/Logs/$(date '+%Y%m%d_%H%M%S').log"
readonly LOGFILE
mkdir -p "$(dirname "${LOGFILE}")"

# TODO consider differentiating errors from logs (e.g. adding an error keyword
# to err function or writing stderr to a different file
# Redirect all output (stdout + stderr) to both the log file and the terminal
# TODO consider also logging stderr separately (stdout + std err and std err)
exec > >(tee -i "$LOGFILE") 2>&1

function run_all
{
    pushd "$1" || exit "${EXIT_FILE_IO_ERROR}"
    # shellcheck source=/dev/null
    ./run_all.sh
    popd || exit "${EXIT_FILE_IO_ERROR}"
}

# TODO set timezone before running anything...
# TODO fix
# see: https://linuxize.com/post/how-to-set-or-change-timezone-on-debian-10/
# see: https://chatgpt.com/share/e001132e-2bfc-4b68-ab99-8697da44ccc2
# timedatectl set-timezone Europe/Vienna

run_all "CLI_Ubuntu"
run_all "Ubuntu"
# try_platform "PopOS_22.04"
run_all "Android_13"
run_all "DistroAgnostic"

# TODO: Why does the pwd show in logs after this message?
echo -e "${GREEN}run_init.sh: All configuration scripts run successfully.${NC}"
