#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# BASE IMAGE: WSL Ubuntu 22.04
# TODO use stow or some other symlink resp. git bare solution instead of copying

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
# TODO set the current directory

# shellcheck source=/dev/null
. ../CommonInitScripts/mkdirs.sh # TODO this is not a dotfile

# ==== Dotfiles ====
# shellcheck source=/dev/null
. ../CommonInitScripts/git_config.sh.ps1

# shellcheck source=/dev/null
. ../CommonInitScripts/install_dotfiles.sh

# ==== Misc ====
update-alternatives --set editor \
	"$(whereis nvim | awk '{ print $2 }')"
