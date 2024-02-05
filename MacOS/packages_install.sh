#!/bin/bash -x

# Inspiration:
# - https://github.com/nhoizey/macOS-init/blob/main/run-first.sh
# https://about.gitlab.com/blog/2020/04/17/dotfiles-document-and-automate-your-macbook-setup/
# https://gitlab.com/dnsmichi/dotfiles
# 


# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/janor/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update

brew install gcc
brew install todoist logitech-options zoom whatsapp
brew install alacritty
