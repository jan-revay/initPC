#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

if [[ "$(lsb_release --description --short)" != 'Pop!_OS 22.04 LTS' ]]; then
    echo 'Error: The base image does not match "Pop!_OS 22.04 LTS"! Aborting.'
    exit 1
fi

if uname -r | grep "WSL2"; then
    echo "Warning: The base image runs in WSL."
fi

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
