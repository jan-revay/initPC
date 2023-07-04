#!/bin/bash -x
# BASE IMAGE Android 13
set -e

pkg update
pkg upgrade

pkg install x11-repo
# TODO setup termux X11 see https://github.com/termux/termux-x11

pkg install build-essential
pkg install git
pkg install htop
pkg install man
pkg install neofetch
pkg install neovim
pkg install openssh
pkg install python
pkg install ripgrep
pkg install tmux
pkg install tree


