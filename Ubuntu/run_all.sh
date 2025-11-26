#!/bin/bash
. ../prelude.sh
# This script should be idempotent.

if distro_is ubuntu && distro_version_ge 24 && gnome_present yes; then
    # TODO "Which services should be restarted?" prompt is still present in VM
    # TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
    # TODO - move to packages_install.sh
    export NEEDRESTART_MODE=a
    export NEEDRESTART_SUSPEND=1

    # Run stuff that requires user input first (if not turned off by `--noninteractive`)
    for script in [0-9][0-9]*.sh; do
        [ -e "$script" ] || continue # skip if no match
        # shellcheck source=/dev/null
        [ -f "$script" ] && . "$script"
    done
fi
