#!/bin/bash -x
# BASE IMAGE Android 13


pkg update
pkg upgrade

pkg install x11-repo
# TODO setup termux X11 see https://github.com/termux/termux-x11

pkg install man
pkg install neovim
pkg install build-essential
pkg install git
pkg install python
pkg install openssh
pkg install ripgrep
pkg install tree
pkg install neofetch
pkg install htop
pkg install tmux


