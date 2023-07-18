#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

if [[ "$(lsb_release --description --short)" != 'Pop!_OS 22.04 LTS' ]]; then
    echo 'Error: The base image does not match "Pop!_OS 22.04 LTS"! Aborting.'
    exit 1
fi

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh
