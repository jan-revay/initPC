#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 24

# stuff that requires user input can be turned off by `--noninteractive` CLI param
for script in [0-9][0-9]*.sh; do
   [ -f "$script" ] && . "$script"
done

