#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is kali
distro_version_ge 2023
gnome_present no

# Let's try to keep the Ubuntu install script Kali compatible
. ../UbuntuCLI/packages_install.sh
# TODO create kali_specific_packages.sh
. ../UbuntuCLI/optional_packages_install.sh
. ../DebianCLI/debian_specific_packages.sh # last, because some packages are built from source
# stuff that requires user input can be turned off by `--noninteractive` CLI param
. ../UbuntuCLI/interactive_part.sh
. ../UbuntuCLI/configs_install.sh
