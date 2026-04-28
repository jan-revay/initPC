#!/bin/bash
. ../prelude.sh
# This script should be idempotent.

# TODO turn off logging for prelude, rename files with no dot or add regex and
# use run-parts to run the scripts
# TODO TOREAD https://www.reddit.com/r/linuxquestions/comments/1s3i5lb/do_you_actually_use_bash_for_your_scripts_or_just/

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
