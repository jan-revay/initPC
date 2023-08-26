#!/bin/bash -x
# BASE IMAGE: WSL Debian 12
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if ! grep 'PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"' /etc/os-release; then
    echo 'Error: The base image does not match "Debian GNU/Linux 12 (bookworm)"! Aborting.'
    exit 1
fi

if ! uname -r | grep "WSL2"; then
    echo "Warning: The base image probably does not run in WSL."
    exit 2
fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ../WSL_Ubuntu_22.04/interactive_part.sh

# Let's try to keep the Ubuntu install script Debian compatible

. ../WSL_Ubuntu_22.04/packages_install.sh

. ../WSL_Ubuntu_22.04/configs_install.sh

. ./source_packages_install.sh
