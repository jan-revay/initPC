#!/bin/bash
. ../prelude.sh
# BASE IMAGE: Android 13

if [ ! -d ~/storage ]; then
    termux-setup-storage
fi

touch ~/.bashrc # Termux does not create .bashrc by default but some scripts use it
