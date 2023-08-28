#!/bin/bash -x
# BASE IMAGE: WSL Debian 12
# The script should not require any user input and should be idempotent.

# Packages that are installed on Ubuntu, but not available on Debian (e.g. PPAs)
# are installed here.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

cd ~/x/

if ! test -d helix; then
    git clone https://github.com/helix-editor/helix
fi

cd helix
git pull
cargo install --path helix-term --locked
mkdir -p ~/.config/helix/
# TODO fix hx --Health warning:
# `Runtime directory does not exist: /home/jr/.cargo/bin/runtime`
# TODO fix recursive runtime directory nesting
ln -f -s "$PWD/runtime" ~/.config/helix/runtime
hx --grammar fetch
hx --grammar build
hx --health

# TODO - do I need to use --force parameter to update cargo packages?
# see: https://github.com/o2sh/onefetch/wiki/Installation#cargo
cargo install onefetch