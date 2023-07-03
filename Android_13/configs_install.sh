#!/bin/bash -x
# BASE IMAGE: Android 13

# CONFIG
termux-setup-storage

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

../SharedConfigs/git_and_mkdirs.ps1

# .bashrc stuff
cp ../SharedConfigs/.my_bashrc ~/
cp ../SharedConfigs/.bash_aliases ~/

touch ~/.bashrc

if ! grep my_bashrc ~/.bashrc; then
echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi

if ! grep .bash_aliases ~/.bashrc; then
echo "
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi" >> ~/.bashrc
fi
