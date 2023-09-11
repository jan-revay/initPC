#!/bin/bash -x

# WIP


if [[ "${__PRELUDE_SOURCED__}" == "true" ]]; then
    __PRELUDE_SOURCED__='true'

    # TODO add this (including color consts) to a prelude script
    # TODO make exit codes named constants in the prelude script
    # makes the echo prompt yellow to improve readability
    export PS4="\[\033[1;93m\]+ \[\033[0m\]"
    set -e # exit on error

    readonly RED='\033[0;31m'
    readonly NC='\033[0m' # No Color

    readonly EXIT_SUCCESS=0
    readonly EXIT_FILE_IO_ERROR=50
    readonly EXIT_INCORRECT_PLATFORM=126
    
    # TODO - finish
fi
