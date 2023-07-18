#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if ! grep 'PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"' /etc/os-release; then
    echo 'Error: The base image does not match "Debian GNU/Linux 12 (bookworm)"! Aborting.'
    exit 1
fi

if [[ ! -f "/etc/wsl.conf" ]]; then
    echo "Warning: The base image probably does not run in WSL."
fi

# Let's try to keep the Ubuntu install script Debian compatible
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/packages_install.sh
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/configs_install.sh