#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is kali
distro_version_ge 2023
gnome_present no

# Let's try to keep the Ubuntu install script Kali compatible
. ../CLI_Ubuntu/packages_install.sh
# TODO create kali_specific_packages.sh
. ../CLI_Ubuntu/optional_packages_install.sh
. ../DebianCLI/debian_specific_packages.sh # last, because some packages are built from source
# stuff that requires user input can be turned off by `--noninteractive` CLI param
. ../CLI_Ubuntu/interactive_part.sh
. ../CLI_Ubuntu/configs_install.sh
