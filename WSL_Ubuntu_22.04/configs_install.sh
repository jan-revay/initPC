#!/bin/bash -x
# The script should not require any user input.
# BASE IMAGE: WSL Ubuntu 22.04
# TODO use stow or some other symlink resp. git bare solution instead of copying

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
# TODO set current directory

# shellcheck source=/dev/null
. ../Dotfiles/git_config.sh.ps1
# shellcheck source=/dev/null
. ../Dotfiles/mkdirs.sh

# .bashrc stuff
cp ../Dotfiles/.my_bashrc ~/
cp ../Dotfiles/.bash_aliases ~/

if ! grep my_bashrc ~/.bashrc; then
echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi

sudo update-alternatives --set editor /usr/bin/nvim
