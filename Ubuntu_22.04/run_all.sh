#!/bin/bash -x
# BASE IMAGE: Ubuntu 22.04

. ../prelude.sh

# TODO what about supporting all Ubuntu 2x versions?
# TODO Ubuntu 23.04 works, hence it can be allowed, make this official
# TODO - change the naming of directories so that it does not include the version or
# make it clear that the specified version is minimal.
distro_is ubuntu
distro_version_ge 22

if uname -r | grep "WSL2"; then
    echo "Warning: The script runs in WSL."
fi

if ! gnome-extensions --version; then
    echo 'gnome-extensions not found'
    exit ${EXIT_INCORRECT_PLATFORM}
fi

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
# TODO - move to packages_install.sh
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. interactive_part.sh

. packages_install.sh

. ../WSL_Ubuntu_22.04/ubuntu_specific_packages.sh

. configs_install.sh

echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
