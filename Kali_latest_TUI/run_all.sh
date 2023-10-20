#!/bin/bash -x
# BASE IMAGE: Kali Linux rolling (latest)
# The script should not require any user input and should be idempotent.

. ../prelude.sh

distro_is kali
distro_version_ge 2023
gnome_present no

# TODO remove resp. rename the script directory
# if ! uname -r | grep "WSL2"; then
#     echo "Warning: The base image probably does not run in WSL."
#     exit 2
# fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ../WSL_Ubuntu_22.04/interactive_part.sh

# Let's try to keep the Ubuntu install script Debian compatible

. ../WSL_Ubuntu_22.04/packages_install.sh

. ../WSL_Ubuntu_22.04/configs_install.sh

# TODO create kali_specific_packages.sh
. ../WSL_Debian_12/debian_specific_packages.sh # last, because some packages are built from source

# . ../WSL_Ubuntu_22.04/packages_install_optional.sh
