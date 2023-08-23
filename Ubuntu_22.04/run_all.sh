#!/bin/bash -x
# BASE IMAGE: Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# TODO add Ubuntu version
if [[ "$(lsb_release --description --short)" != 'Ubuntu 22.04'* ]]; then
    echo 'Error: The base image does not match "Ubuntu 22.04"! Aborting.'
    exit 1
fi

if [[ -f "/etc/wsl.conf" ]]; then
    echo "Warning: The base image is WSL, use the WSL Ubuntu installer instead."
fi

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ./ppa_packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh

reboot
