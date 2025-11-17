#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is debian
distro_version_ge 12
gnome_present no

# Let's try to keep the Ubuntu install script Debian compatible
. ../CLI_Ubuntu/packages_install.sh
. ../CLI_Ubuntu/optional_packages_install.sh
. debian_specific_packages.sh # last, because some packages are built from source
# stuff that requires user input can be turned off by `--noninteractive` CLI param
. ../CLI_Ubuntu/interactive_part.sh
. ../CLI_Ubuntu/configs_install.sh
