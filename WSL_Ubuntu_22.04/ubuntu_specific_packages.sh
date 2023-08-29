#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# list install is not idempotent for some reason - TODO fix
# SNAP_PACKAGES+=(dust procs onefetch) - 
time sudo snap install dust
time sudo snap install procs
time sudo snap install onefetch
time sudo snap install helix --classic