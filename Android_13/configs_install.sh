#!/bin/bash -x
# BASE IMAGE: Android 13

. ../prelude.sh

if [ ! -d ~/storage ]; then
    termux-setup-storage
fi

touch ~/.bashrc # Termux does not create .bashrc by default but some scripts use it

pushd ../CommonInitScripts/ || exit ${EXIT_FILE_IO_ERROR}
# TODO cd in sharedConfig.sh
# shellcheck source=/dev/null
. sharedConfig.sh
popd || exit ${EXIT_FILE_IO_ERROR}
