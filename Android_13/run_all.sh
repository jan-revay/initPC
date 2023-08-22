#!/bin/bash -x
# BASE IMAGE: Android 13

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
export DEBIAN_FRONTEND=noninteractive

if ! gh auth status; then
    pkg update
    pkg install gh
    gh auth login --hostname github.com
fi

# TODO add check for android

./packages_install.sh
./configs_install.sh
