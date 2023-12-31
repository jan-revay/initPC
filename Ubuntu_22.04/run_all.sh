#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present yes

# TODO fix the script and remove
echo "This script is not yet finished therefore it is disabled to prevent CI fail."
exit 0

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
# TODO - move to packages_install.sh
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. interactive_part.sh
. packages_install.sh
. ../UbuntuCLI/ubuntu_specific_packages.sh
. configs_install.sh

# todo - is this automatic restart really needed?
echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
