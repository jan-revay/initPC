#!/bin/bash
# BASE IMAGE: Android 13

. ../prelude.sh

if uname -a | grep Android; then
    # TODO Move the if to a separate script file
    if ! gh auth status; then
        pkg update
        pkg install gh
        gh auth login --hostname github.com
    fi

    # Run stuff that requires user input first (if not turned off by `--noninteractive`)
    for script in [0-9][0-9]*.sh; do
        [ -e "$script" ] || continue # skip if no match
        # shellcheck source=/dev/null
        [ -f "$script" ] && . "$script"
    done
fi
