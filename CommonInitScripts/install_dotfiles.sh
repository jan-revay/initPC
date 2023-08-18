#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# BASE IMAGE: ALL
# TODO use stow or some other symlink resp. git bare solution instead of copying

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# Using bare git repo for management of config files
# see: https://www.atlassian.com/git/tutorials/dotfiles
BRANCH=$(git symbolic-ref --short HEAD)
readonly BRANCH
alias dot='/usr/bin/git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}"'
if [ -d .dotfiles ]; then
    echo ".dotfiles" > ~/.gitignore
    git clone --bare https://github.com/jan-revay/dotfiles.git \
        "${HOME}/.dotfiles" --branch "${BRANCH}"
    # echo "*" > ~/.gitignore  # secure option

    # TODO improve not to filter just the dot
    mkdir -p ~/.dotfiles_automatic_backup/
    dot checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | \
        xargs -I{} mv {} .old_dotfiles/{}
    dot checkout
    dot config --local status.showUntrackedFiles no
else
    dot pull
    dot checkout "${BRANCH}"
fi

# TODO consider having git tracked .bashrc (that way I don't need to add anything)
# ==== .bashrc stuff ====
if ! grep my_bashrc ~/.bashrc; then
    echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi