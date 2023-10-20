#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present no

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. interactive_part.sh
. ubuntu_specific_packages.sh
. packages_install.sh
# . packages_install_optional.sh
. configs_install.sh
