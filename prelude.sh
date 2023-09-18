#!/bin/bash -x

# WIP

if [[ "${__INITPC_PRELUDE_SOURCED__}" != "true" ]]; then
    __INITPC_PRELUDE_SOURCED__='true'

    # TODO add this (including color consts) to a prelude script
    # makes the echo prompt yellow to improve readability
    # TODO toread:
    # https://linuxopsys.com/topics/customizing-bash-prompt-in-linux-changing-colors
    # https://gist.github.com/vratiu/9780109
    # https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
    # https://opensource.com/article/19/9/linux-terminal-colors
    # https://linuxopsys.com/topics/customizing-bash-prompt-in-linux-changing-colors
    # https://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
    # https://unix.stackexchange.com/questions/148/colorizing-your-terminal-and-shell-environment
    # https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4
    set -e # exit on error

    # shellcheck disable=SC2034
    readonly RED='\033[0;31m'
    # shellcheck disable=SC2034
    readonly IYELLOW='\033[0;93m' # high intensity yellow
    # shellcheck disable=SC2034
    readonly GREEN='\033[0;32m'
    # shellcheck disable=SC2034
    readonly NC='\033[0m' # No Color

    export PS4="\[${IYELLOW}\]+ \[${NC}\]"

    # TODO renumber the exit codes according to the docs bellow
    # SEE: https://manpages.ubuntu.com/manpages/lunar/man3/sysexits.h.3head.html
    # SEE: https://tldp.org/LDP/abs/html/exitcodes.html
    # shellcheck disable=SC2034
    readonly EXIT_SUCCESS=0
    # shellcheck disable=SC2034
    readonly EXIT_FILE_IO_ERROR=50
    # TODO - consider even better error code number (guaranteed to be unique)
    # shellcheck disable=SC2034
    readonly EXIT_INCORRECT_PLATFORM=100
    # shellcheck disable=SC2034
    readonly EXIT_INVALID_ARGUMENT=10
    # TODO - finish
fi
