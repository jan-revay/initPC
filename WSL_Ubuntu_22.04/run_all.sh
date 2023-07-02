#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# User input required: single keypress during the LLVM install, the rest should
# be silent.

if [[ `lsb_release -d -s` != "Ubuntu 22.04.2 LTS" ]]; then 
    echo "Error: The base image does not match Ubuntu 22.04.2 LTS! Aborting"
    exit 1
fi

if [[ ! -f "/etc/wsl.conf" ]]; then
    echo "Warning: The base image probably does not run in WSL."
fi

./packages_install.sh
./configs_install.sh