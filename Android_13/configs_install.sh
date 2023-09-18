#!/bin/bash -x
# BASE IMAGE: Android 13

. ../prelude.sh

if [ ! -d ~/storage ]; then
    termux-setup-storage
fi

touch ~/.bashrc # Termux does not create .bashrc by default but some scripts use it
. ../CommonInitScripts/sharedConfig.sh
