#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# TODO Ubuntu 23.04 works, hence it can be allowed, make this official
if [[ "$(lsb_release --description --short)" != 'Ubuntu 22.04'* &&
"$(lsb_release --description --short)" != 'Ubuntu 23.04'* ]]; then
    echo 'Error: The base image does not match "Ubuntu 22.04"! Aborting.'
    exit 126
fi

# TODO remove resp. rename the script directory
# if ! uname -r | grep "WSL2"; then
#     echo "Warning: The base image probably does not run in WSL."
#     exit 2
# fi

if gnome-extensions --version; then
    echo 'Use Ubuntu Desktop installer (./Ubuntu_22.04)'
    echo 'This script is targeted only to CLI installations'
    exit 126
fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ./interactive_part.sh

. ./ubuntu_specific_packages.sh

. ./packages_install.sh

# . ./packages_install_optional.sh

. ./configs_install.sh
