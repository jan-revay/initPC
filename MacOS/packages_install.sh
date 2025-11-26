#!/bin/bash
. ../prelude.sh

# TODO       - name: Make script executable
#        run: chmod +x ./MacOS/packages_install.sh
# Inspiration:
# - https://github.com/nhoizey/macOS-init/blob/main/run-first.sh
# https://about.gitlab.com/blog/2020/04/17/dotfiles-document-and-automate-your-macbook-setup/
# https://gitlab.com/dnsmichi/dotfiles
#

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# shellcheck disable=SC2016
(
    echo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >> /Users/janor/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

brew install gcc git gh
brew install todoist logi-options-plus zoom whatsapp messenger
brew install alacritty
