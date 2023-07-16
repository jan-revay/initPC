#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script whould not require any user input.

# make the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

. ../WSL_Ubuntu_22.04/configs_install.sh