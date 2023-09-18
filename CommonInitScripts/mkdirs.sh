#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

. ../prelude.sh

mkdir -p ~/books
mkdir -p ~/x     # all my development repos go here
mkdir -p ~/x/tmp # stuff that can be deleted after restart
