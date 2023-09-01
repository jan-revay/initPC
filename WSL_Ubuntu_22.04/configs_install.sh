#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

. ../CommonInitScripts/mkdirs.sh

# ==== Dotfiles ====
. ../CommonInitScripts/git_config.sh.ps1

. ../CommonInitScripts/install_dotfiles.sh

# ==== Misc ====
sudo update-alternatives --set editor /usr/bin/nvim
