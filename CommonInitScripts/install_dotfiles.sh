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
function dot {
    /usr/bin/git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" $@
}

function backup_dotfiles {
    mkdir -p ~/.dotfiles_automatic_backup/
    OLD_DOTFILES=$(dot checkout 2>&1 | grep -E "\s+\." | awk {'print $1'})
    readonly OLD_DOTFILES

    xargs -I{} mkdir "${HOME}/.dotfiles_automatic_backup/$(basedir {})"
    xargs -I{} mv ~/{} ~/.dotfiles_automatic_backup/{}
}

if [ ! -d ~/.dotfiles ]; then
    echo ".dotfiles" > ~/.gitignore
    # echo "*" > ~/.gitignore  # secure option
    git clone --bare https://github.com/jan-revay/dotfiles.git \
        "${HOME}/.dotfiles" --branch "${BRANCH}"

    # TODO improve not to filter just the dot
    backup_dotfiles
    dot checkout "${BRANCH}"
    dot config --local status.showUntrackedFiles no
else
    dot pull
    backup_dotfiles
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
