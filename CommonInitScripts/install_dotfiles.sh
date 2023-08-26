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
function dot
{
    git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" "$@"
}

# TODO Make .dotfiles_auto_backup a git repo and commit on every new backup (maybe I could even push somewhere upstream)
# TODO broken - does not back up nvim config...
function backup_conflicting_dotfiles
{
    echo -e "${GREEN}Backing up old dotfiles${NC}"
    mkdir -p ~/.dotfiles_auto_backup/
    OLD_DOTFILES=$(dot checkout "${DOTFILES_BRANCH}" 2>&1 | grep "^[[:space:]]\+[^[:space:]]\+$")
    readonly OLD_DOTFILES

    OLD_DOTDIRS=$(echo "$OLD_DOTFILES" | xargs -I{} dirname "${HOME}/.dotfiles_auto_backup/{}")
    echo "$OLD_DOTDIRS" | xargs -I{} mkdir -p {}
    echo "$OLD_DOTFILES" | xargs -I{} mv ~/{} ~/.dotfiles_auto_backup/{}
}

function checkout_dotfiles
{
    DOTFILES_BRANCH=$(git symbolic-ref --short HEAD)
    # e.g. "devel-feature-precommit-hooks" -> "devel"
    DOTFILES_BRANCH=$(echo "${DOTFILES_BRANCH}" | grep -o "[a-z]\+" | head -n 1")
    readonly DOTFILES_BRANCH
    if ! dot checkout "${DOTFILES_BRANCH}"; then
        backup_conflicting_dotfiles
        dot checkout "${DOTFILES_BRANCH}"
    fi

    echo -e "${GREEN}Checked out dotfiles branch: ${DOTFILES_BRANCH}${NC}"
}

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
