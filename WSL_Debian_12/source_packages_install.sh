#!/bin/bash -x
# BASE IMAGE: WSL Debian 12
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

cd ~/x/
git clone https://github.com/helix-editor/helix
cd helix
cargo install --path helix-term --locked
ln -s $PWD/runtime ~/.config/helix/runtime