#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

if [[ "$(lsb_release --description --short)" != 'Pop!_OS 22.04 LTS' ]]; then
    echo 'Error: The base image does not match "Pop!_OS 22.04 LTS"! Aborting.'
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

. ./packages_install.sh
. ./configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
