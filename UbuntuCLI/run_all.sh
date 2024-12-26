#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present no

. ubuntu_specific_packages.sh
. packages_install.sh
# stuff that requires user input can be turned off by `--noninteractive` CLI param
. interactive_part.sh
. optional_packages_install.sh
. configs_install.sh
