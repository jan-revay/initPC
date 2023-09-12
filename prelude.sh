#!/bin/bash -x

# WIP


if [[ "${__INITPC_PRELUDE_SOURCED__}" == "true" ]]; then
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

    readonly RED='\033[0;31m'
    readonly IYELLOW='\033[0;93m' # high intensity yellow
    readonly GREEN='\033[0;32m'
    readonly NC='\033[0m' # No Color
    
    export PS4="\[${IYELLOW}\]+ \[${NC}\]"

    readonly EXIT_SUCCESS=0
    readonly EXIT_FILE_IO_ERROR=50
    readonly EXIT_INCORRECT_PLATFORM=126
    
    # TODO - finish
fi
