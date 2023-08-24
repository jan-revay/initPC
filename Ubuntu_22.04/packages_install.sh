#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if lspci | grep -i vmware; then  # if the script is running inside of a VMware virtual machine
    sudo apt install -y open-vm-tools open-vm-tools-desktop  # install "VMware tools" (drivers)
else # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify
    # sudo snap install zoom-client
    sudo apt install -y logiops
fi

# WSL Ubuntu script installs command line applications
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/packages_install.sh
# Programs with GUI are added below

# TODO add packages from PopOS here (and use this as a base for the PopOS)

# GNOME extensions
. ../CommonInitScripts/gnome_install_extensions.sh
