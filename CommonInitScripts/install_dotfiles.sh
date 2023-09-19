#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# BASE IMAGE: ALL
# Dotfiles are managed via bare git repository.
# see: https://www.atlassian.com/git/tutorials/dotfiles

. ../prelude.sh

function dot
{
    git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}" "$@"
}

# TODO Make .dotfiles_auto_backup a git repo and commit on every new backup (maybe I could even push somewhere upstream)
function backup_conflicting_dotfiles
{
    local DOTFILES_BRANCH="$1"
    readonly DOTFILES_BRANCH
    echo -e "${GREEN}Backing up old dotfiles${NC}"
    mkdir -p ~/.dotfiles_auto_backup/
    local OLD_DOTFILES
    OLD_DOTFILES=$(dot checkout "${DOTFILES_BRANCH}" 2>&1 | grep "^[[:space:]]\+[^[:space:]]\+$")
    readonly OLD_DOTFILES

    local OLD_DOTDIRS
    OLD_DOTDIRS=$(echo "$OLD_DOTFILES" | xargs -I{} dirname "${HOME}/.dotfiles_auto_backup/{}")
    readonly OLD_DOTDIRS
    echo "$OLD_DOTDIRS" | xargs -I{} mkdir -p {}
    echo "$OLD_DOTFILES" | xargs -I{} mv ~/{} ~/.dotfiles_auto_backup/{}
}

function checkout_dotfiles
{
    local DOTFILES_BRANCH=devel

    # if HEAD is not detached
    if git symbolic-ref --short HEAD; then
        local HEAD
        HEAD=$(git symbolic-ref --short HEAD)
        readonly HEAD

        if [[ "${HEAD}" == "minimal" ||
            "${HEAD}" == "stable" ||
            "${HEAD}" == "testing" ]]; then
            DOTFILES_BRANCH="${HEAD}"
        fi
    fi

    readonly DOTFILES_BRANCH

    if ! dot checkout "${DOTFILES_BRANCH}"; then
        backup_conflicting_dotfiles "${DOTFILES_BRANCH}"
        dot checkout "${DOTFILES_BRANCH}"
    fi

    echo -e "${GREEN}Checked out dotfiles branch: ${DOTFILES_BRANCH}${NC}"
}

# TODO consider using git checkout --force as a simplification
if [ ! -d ~/.dotfiles ]; then
    # TODO - is this idempotent?
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

if ! grep .bash_aliases ~/.bashrc; then
    echo "
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi" >> ~/.bashrc
fi
