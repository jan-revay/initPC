#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# BASE IMAGE: ALL
# TODO use stow or some other symlink resp. git bare solution instead of copying

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

mkdir -p ~/.old_dotfiles/

mv ~/.my_bashrc ~/.old_dotfiles/ || true
mv ~/.bash_aliases ~/.old_dotfiles/ || true

ln -s "$(realpath ../Dotfiles/.my_bashrc)" ~/
ln -s "$(realpath ../Dotfiles/.bash_aliases)" ~/

# ==== .bashrc stuff ====
if ! grep my_bashrc ~/.bashrc; then
    echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi