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
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# TODO what is this app and why does it automatically installs itself on Ubuntu
# server/desktop, but not in wsl? It needs user interaction hece adding it here.
sudo apt install postfix

# GNOME extensions
. ../CommonInitScripts/gnome_install_extensions.sh

# Run stuff that requires user input first
# WARNING: gh auth login --with-token is somehow broken (git asks for pw anyway)
if ! gh auth status; then
    sudo apt update
    sudo apt install gh
    gh auth login --hostname github.com
fi

# shellcheck source=/dev/null
. ./packages_install.sh
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/ppa_packages_install.sh
# shellcheck source=/dev/null
. ./configs_install.sh

reboot
