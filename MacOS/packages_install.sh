#!/bin/bash -x

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/janor/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install gcc
brew install 
