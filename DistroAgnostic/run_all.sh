#!/bin/bash
. ../prelude.sh
# This script should be idempotent.

# Run stuff that requires user input last (if not turned off by `--noninteractive`)
for script in [0-9][0-9]*.sh; do
    [ -e "$script" ] || continue # skip if no match
    # shellcheck source=/dev/null
    [ -f "$script" ] && . "$script"
done

if gnome_present yes; then

    pushd "gnome" || exit "${EXIT_FILE_IO_ERROR}"

    # Run stuff that requires user input last (if not turned off by `--noninteractive`)
    for script in [0-9][0-9]*.sh; do
        [ -e "$script" ] || continue # skip if no match
        # shellcheck source=/dev/null
        [ -f "$script" ] && . "$script"
    done

    popd || exit "${EXIT_FILE_IO_ERROR}"
fi
