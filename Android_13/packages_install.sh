#!/bin/bash -x
# BASE IMAGE Android 13

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
export DEBIAN_FRONTEND=noninteractive

# TODO group packages as in WSL_Ubuntu
pkg update -y
pkg upgrade -y
pkg upgrade -y # running upgrade once is sometimes not enough

# pkg install -y x11-repo
# TODO setup termux X11 see https://github.com/termux/termux-x11

APT_PACKAGES=(wget gnupg curl tar)
APT_PACKAGES+=(build-essential gdb ccache ninja cmake) # GCC and build tools
# APT_PACKAGES+=(rust rustc-dev rust-analyzer) - broken
APT_PACKAGES+=(python python-numpy) # python
APT_PACKAGES+=(nodejs)              # JavaScript
APT_PACKAGES+=(neovim helix)        # code editors
# utils - TODO organize
APT_PACKAGES+=(cppcheck iwyu shfmt shellcheck)         # static analyzers
APT_PACKAGES+=(valgrind doxygen)                       # other coding tools
APT_PACKAGES+=(zsh fish tmux tree dust onefetch procs) # shells and commands
APT_PACKAGES+=(tokei fd gh git htop bat exa jq man neofetch openssh ripgrep)
APT_PACKAGES+=(imagemagick)
APT_PACKAGES+=(proot-distro) # ubuntu/debian emulation

pkg install -y "${APT_PACKAGES[@]}"
apt list --upgradable

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
# TODO init distro and choose the method (there are various setup scripts for that)
# TODO run a version of my ubuntu init scripts here
# TODO do a more research about differences between termux and proot-distro and
# linux emulators that other apps use (resp. other install scripts)
# TODO try to compile sth. in that Ubuntu resp. in Termux
proot-distro install ubuntu
# proot-distro login ubuntu -- \
#     "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
#      sh -s -- -y"
