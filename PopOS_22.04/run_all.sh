#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

. ../prelude.sh

if [[ "$(lsb_release --description --short)" != 'Pop!_OS 22.04 LTS' ]]; then
    echo 'Error: The base image does not match "Pop!_OS 22.04 LTS"! Aborting.'
    exit ${EXIT_INCORRECT_PLATFORM}
fi

if uname -r | grep "WSL2"; then
    echo "Warning: The script runs in WSL."
fi

if ! gnome-extensions --version; then
    echo 'gnome-extensions not found'
    exit ${EXIT_INCORRECT_PLATFORM}
fi

. packages_install.sh
. configs_install.sh

# TODO this is not compatible with refresh command and run_init.sh
echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
