#!/bin/bash
. ../prelude.sh
# This script should be idempotent.

if distro_is ubuntu && distro_version_ge 24; then
    # stuff that requires user input can be turned off by `--noninteractive` CLI param
    for script in [0-9][0-9]*.sh; do
        [ -e "$script" ] || continue # skip if no match
        # shellcheck source=/dev/null
        [ -f "$script" ] && . "$script"
    done
fi
