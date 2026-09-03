#!/bin/bash
. ../prelude.sh
# This script should be idempotent.

# TODO use run-parts utility for running the script parts
# create a special configured run-parts function
# in prelude e.g. my-run-parts and run it here
# TODO do pushd and popd here so that the runner can be
# triggered from anywhere (compute absolute path to the
# script) ??

# TODO - add a flag to ignore distro and distro distro version
# so that I can run this script on Debian and Kali containers
# for CI & testing
if distro_is ubuntu && distro_version_ge 24; then
    # stuff that requires user input can be turned off by `--noninteractive` CLI param
    for script in [0-9][0-9]*.sh; do
        [ -e "$script" ] || continue # skip if no match
        # shellcheck source=/dev/null
        [ -f "$script" ] && . "$script"
    done
fi
