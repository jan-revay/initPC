#!/bin/bash -x
# BASE IMAGE: Android 13

set -e

# CONFIG
termux-setup-storage

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

. ../Dotfiles/git_config.sh.ps1
. ../Dotfiles/mkdirs.sh

# .bashrc stuff
cp ../Dotfiles/.my_bashrc ~/
cp ../Dotfiles/.bash_aliases ~/

touch ~/.bashrc

if ! grep my_bashrc ~/.bashrc; then
    echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >>~/.bashrc
fi

if ! grep .bash_aliases ~/.bashrc; then
    echo "
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi" >>~/.bashrc
fi
