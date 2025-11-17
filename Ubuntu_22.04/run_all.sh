#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present yes

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
# TODO - move to packages_install.sh
# TODO - call every sub-script from here - don't use nested script composition
# TODO - remove support for ubuntu versions prior to 26.04
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. packages_install.sh
. ../UbuntuCLI/ubuntu_specific_packages.sh
. ../UbuntuCLI/optional_packages_install.sh
. interactive_part.sh
. configs_install.sh
. gsettings.sh
. extensions_gsettings.sh

# todo - is this automatic restart really needed?
# TODO - only restart after the first run
# echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
# sleep 30
# reboot
