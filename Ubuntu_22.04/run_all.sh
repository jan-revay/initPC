#!/bin/bash -x
# BASE IMAGE: Ubuntu 22.04
# The script should not require any user input.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if [[ "$(lsb_release --description --short)" != 'Ubuntu 22.04.2 LTS' ]]; then 
    echo 'Error: The base image does not match "Ubuntu 22.04.2 LTS"! Aborting.'
    exit 1
fi

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh