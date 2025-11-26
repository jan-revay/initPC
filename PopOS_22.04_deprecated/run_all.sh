#!/bin/bash
# This script should be idempotent.
# shellcheck disable=SC2317  # Don't warn about unreachable commands in this file

exit 1 # THIS script needs to be updated...

. ../prelude.sh

distro_is pop
distro_version_ge 22
gnome_present yes

if uname -r | grep "WSL2"; then
    echo "Warning: The script runs in WSL."
fi

. packages_install.sh
. configs_install.sh

# TODO this is not compatible with refresh command and run_init.sh
echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
