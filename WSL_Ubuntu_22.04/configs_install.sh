#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

../SharedConfigs/configs_install_shared.sh

# .bashrc stuff
cp ../SharedConfigs/.my_bashrc ~/
cp ../SharedConfigs/.bash_aliases ~/

if ! grep my_bashrc ~/.bashrc; then
echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi

sudo update-alternatives --set editor /usr/bin/vim.basic