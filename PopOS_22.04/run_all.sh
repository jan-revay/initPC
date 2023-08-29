#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if [[ "$(lsb_release --description --short)" != 'Pop!_OS 22.04 LTS' ]]; then
    echo 'Error: The base image does not match "Pop!_OS 22.04 LTS"! Aborting.'
    exit 126
fi

if uname -r | grep "WSL2"; then
    echo "Warning: The script runs in WSL."
fi

if ! gnome-extensions --version; then
    echo 'gnome-extensions not found'
    exit 126
fi

. ./packages_install.sh
. ./configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
