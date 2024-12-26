#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is debian
distro_version_ge 12
gnome_present no

# Let's try to keep the Ubuntu install script Debian compatible
. ../UbuntuCLI/packages_install.sh
. ../UbuntuCLI/optional_packages_install.sh
. debian_specific_packages.sh # last, because some packages are built from source
# stuff that requires user input can be turned off by `--noninteractive` CLI param
. ../UbuntuCLI/interactive_part.sh
. ../UbuntuCLI/configs_install.sh
