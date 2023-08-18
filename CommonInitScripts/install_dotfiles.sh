#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# BASE IMAGE: ALL
# TODO use stow or some other symlink resp. git bare solution instead of copying

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# TODO replace tabs with spaces
# Using bare git repo for management of config files
# see: https://www.atlassian.com/git/tutorials/dotfiles
function dot {
    /usr/bin/git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" $@
}

# TODO Make .dotfiles_auto_backup a git repo and commit on every new backup (maybe I could even push somewhere upstream)
function backup_conflicting_dotfiles {
    echo -e "${GREEN}Backing up old dotfiles${NC}"
    mkdir -p ~/.dotfiles_auto_backup/
    OLD_DOTFILES=$(dot checkout 2>&1 | grep "^[[:space:]][^[:space:]]\+$" | awk {'print $1'})
    readonly OLD_DOTFILES

    OLD_DOTDIRS=$(echo "$OLD_DOTFILES" | xargs -I{} dirname ${HOME}/.dotfiles_auto_backup/{})
    echo "$OLD_DOTDIRS" | xargs -I{} mkdir -p {}
    echo "$OLD_DOTFILES" | xargs -I{} mv ~/{} ~/.dotfiles_auto_backup/{}
}

function checkout_dotfiles {
    BRANCH=$(git symbolic-ref --short HEAD)
    readonly BRANCH
    if ! dot checkout "${BRANCH}"; then
        backup_conflicting_dotfiles
        dot checkout "${BRANCH}"
    fi

    echo -e "${GREEN}Checked out dotfiles branch:" ${BRANCH}${NC}
}
# TODO merge similar stuff in the two branches of the if stmnt
# TODO consider using git checkout --force as a simplification
if [ ! -d ~/.dotfiles ]; then
    echo ".dotfiles" > ~/.gitignore
    # echo "*" > ~/.gitignore  # secure option
    git clone --bare https://github.com/jan-revay/dotfiles.git "${HOME}/.dotfiles"
fi

checkout_dotfiles
dot config --local status.showUntrackedFiles no
dot pull

# TODO consider having git tracked .bashrc (that way I don't need to add anything)
# ==== .bashrc stuff ====
if ! grep my_bashrc ~/.bashrc; then
    echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi
