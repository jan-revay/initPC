#!/bin/bash
. ../prelude.sh
# The script should not require any user input and should be idempotent.

mkdir -p ~/books
mkdir -p ~/x     # all my development repos go here
mkdir -p ~/x/tmp # stuff that can be deleted after restart
# localSW is also created in source_packages.sh (they are installed there)
mkdir -p ~/localSW
mkdir -p ~/tmp
mkdir -p ~/Documents
