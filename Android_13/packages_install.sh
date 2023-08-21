#!/bin/bash -x
# BASE IMAGE Android 13

# TODO group packages as in WSL_Ubuntu
set -e

pkg update -y
pkg upgrade -y
pkg upgrade -y # running upgrade once is sometimes not enough

# pkg install -y x11-repo
# TODO setup termux X11 see https://github.com/termux/termux-x11

APT_PACKAGES=(wget gnupg curl tar)
APT_PACKAGES+=(build-essential gdb ccache ninja cmake) # GCC and build tools
# APT_PACKAGES+=(rust rustc-dev rust-analyzer) - broken
APT_PACKAGES+=(python python-numpy) # python
APT_PACKAGES+=(neovim helix) # code editors
# utils - TODO organize
APT_PACKAGES+=(cppcheck iwyu shfmt valgrind doxygen nodejs) # static analyzers
APT_PACKAGES+=(zsh fish tmux tree dust onefetch procs) # shells and commands
APT_PACKAGES+=(tokei fd gh git htop bat exa jq man neofetch openssh ripgrep)
APT_PACKAGES+=(proot-distro) # ubuntu/debian emulation

pkg install -y "${APT_PACKAGES[@]}"

# TODO the install needs to be executed twice due to pipx - FIX
# because of pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath

pipx install conan
pipx install flawfinder
pipx install cpplint

# pkg install -y matplotlib - DO NOT INSTALL, BROKEN
# pip install pandas - DO NOT INSTALL, BROKEN
# pip install scipy - broken

# rustup is broken TODO fix resp. do equivalent stuff in pkg
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# NPM packages
npm i -g bash-language-server

# TODO - install rust here as android rustup is broken
pkg install 
# TODO init distro and choose the method (there are various setup scripts for that)
# proot-distro install ubuntu
# proot-distro login ubuntu -- \
#    "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
#     sh -s -- -y"
