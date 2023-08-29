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

if uname -r | grep "WSL2"; then
    echo "Error: The script runs in WSL."
    exit 3
fi

if ! gnome-extensions --version; then
    echo 'GNOME not found'
    exit 4
fi

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ./interactive_part.sh

. ./packages_install.sh

. ../WSL_Ubuntu_22.04/ubuntu_specific_packages.sh

. ./configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
