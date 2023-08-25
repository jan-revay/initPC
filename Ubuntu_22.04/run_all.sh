#!/bin/bash -x
# BASE IMAGE: Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# TODO add Ubuntu version
if [[ "$(lsb_release --description --short)" != 'Ubuntu '* ]]; then
    echo 'Error: The base image does not match "Ubuntu 22.04"! Aborting.'
    exit 1
fi

if [[ -f "/etc/wsl.conf" ]]; then
    echo "Warning: The base image is WSL, use the WSL Ubuntu installer instead."
fi

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ./interactive_part.sh

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/ppa_packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
