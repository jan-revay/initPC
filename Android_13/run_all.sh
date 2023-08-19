#!/bin/bash -x
# BASE IMAGE: Android 13

set -e

if ! gh auth status; then
    pkg update
    pkg install gh
    gh auth login --hostname github.com
fi

# TODO add check for android

./packages_install.sh
./configs_install.sh
