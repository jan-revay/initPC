#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# WSL Ubuntu script installs command line applications
. ../WSL_Ubuntu_22.04/packages_install.sh

# Programs with GUI are added below