#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present no

# TODO improve parameter parsing - move it to platform independent code
if [ "$1" = "--help" ]; then
    echo "usage: ./run_all.sh [--noninteractive]"
    echo
    # shellcheck disable=SC2016
    echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
    exit "${EXIT_SUCCESS}"
fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. ubuntu_specific_packages.sh
. packages_install.sh
. interactive_part.sh
# . packages_install_optional.sh
. configs_install.sh
