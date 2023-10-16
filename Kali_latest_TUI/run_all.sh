#!/bin/bash -x
# BASE IMAGE: Kali Linux rolling (latest)
# The script should not require any user input and should be idempotent.

. ../prelude.sh

# TODO - make this a function, use variables, execute os-release as a script
if ! grep 'PRETTY_NAME="Kali GNU/Linux Rolling"' /etc/os-release; then
    echo 'Error: The base image does not match "Kali GNU/Linux Rolling"! Aborting.'
    exit ${EXIT_INCORRECT_PLATFORM}
fi

# TODO remove resp. rename the script directory
# if ! uname -r | grep "WSL2"; then
#     echo "Warning: The base image probably does not run in WSL."
#     exit 2
# fi

if gnome-extensions --version; then
    # TODO - Kali desktop installer
    echo 'Use Kali Desktop installer (TODO)'
    echo 'This script is targeted only to CLI installations'
    exit ${EXIT_INCORRECT_PLATFORM}
fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ../WSL_Ubuntu_22.04/interactive_part.sh

# Let's try to keep the Ubuntu install script Debian compatible

. ../WSL_Ubuntu_22.04/packages_install.sh

. ../WSL_Ubuntu_22.04/configs_install.sh

# TODO create kali_specific_packages.sh
. debian_specific_packages.sh # last, because some packages are built from source

# . ../WSL_Ubuntu_22.04/packages_install_optional.sh
