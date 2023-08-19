#!/bin/bash -x
# BASE IMAGE Android 13
set -e

pkg update -y
pkg upgrade -y

# pkg install -y x11-repo
# TODO setup termux X11 see https://github.com/termux/termux-x11


pkg install -y gnupg
pkg install -y curl
pkg install -y gdb

pkg install -y build-essential
pkg install -y ccache
pkg install -y cmake
pkg install -y cppcheck
pkg install -y iwyu
pkg install -y ninja
pkg install -y shfmt
pkg install -y valgrind
pkg install -y python
pkg install -y python-numpy
# pkg install -y matplotlib - DO NOT INSTALL, BROKEN

pkg install -y gh
pkg install -y git
pkg install -y htop

pkg install -y bat
pkg install -y exa
pkg install -y jq
pkg install -y man
pkg install -y neofetch
pkg install -y openssh
pkg install -y ripgrep
pkg install -y tmux
pkg install -y tree
pkg install -y wget
pkg install -y zsh
pkg install -y fish

pkg install -y neovim

# the install script will probably need to be executed twice
# because of pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install conan
pipx install flawfinder
pipx install cpplint

# pip install pandas - DO NOT INSTALL, BROKEN
# pip install scipy

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
