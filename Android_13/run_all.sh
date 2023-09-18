#!/bin/bash -x
# BASE IMAGE: Android 13

. ../prelude.sh

if ! uname -a | grep Android; then
    echo The init script does not run on Android
    exit ${EXIT_INCORRECT_PLATFORM}
fi

#TODO gh auth does not work (sync woth ubuntu one)
if ! gh auth status; then
    pkg update
    pkg install gh
    gh auth login --hostname github.com
fi

# TODO add check for android

./packages_install.sh
./configs_install.sh
