#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if [[ "$(lsb_release --description --short)" != 'Ubuntu 22.04'* ]]; then
    echo 'Error: The base image does not match "Ubuntu 22.04"! Aborting.'
    exit 1
fi

# TODO remove resp. rename the script directory
# if ! uname -r | grep "WSL2"; then
#     echo "Warning: The base image probably does not run in WSL."
#     exit 2
# fi

if gnome-extensions --version; then
    echo 'Use Ubuntu Desktop installer (./Ubuntu_22.04)'
    echo 'This script is targeted only to CLI installations'
fi

# TODO "Which services should be restarted?" prompt is still present in VM
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ./interactive_part.sh

. ./packages_install.sh

. ./ppa_packages_install.sh

# . ./packages_install_optional.sh

. ./configs_install.sh
