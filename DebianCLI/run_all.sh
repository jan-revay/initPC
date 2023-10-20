#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is debian
distro_version_ge 12
gnome_present no

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ../UbuntuCLI/interactive_part.sh

# Let's try to keep the Ubuntu install script Debian compatible

. ../UbuntuCLI/packages_install.sh
. ../UbuntuCLI/configs_install.sh
. debian_specific_packages.sh # last, because some packages are built from source
# . ../UbubtuCLI/packages_install_optional.sh
