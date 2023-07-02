#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# User input required: single keypress during the LLVM install, the rest should
# be silent.
# TODO is the LLVM installation idempotent? (appears to be so...)
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL

export PS4="\[\033[1;93m\]+ \[\033[0m\]"
readonly GCC_VERSION=12

sudo apt update
sudo apt -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# Install the most recent llvm (see https://apt.llvm.org/) and GCC
pushd /tmp || exit
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh all
rm llvm.sh
popd || exit

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
sudo apt install -y gcc-${GCC_VERSION} rr make build-essential ccache ninja-build

# Apt stuff
sudo apt install -y vim neovim emacs qtcreator kdevelop
sudo apt install -y ripgrep xdotool tree curl neofetch htop tmux at zsh traceroute jq
sudo apt install -y linux-tools-common linux-tools-generic
sudo apt install -y linux-tools-"$(uname -r)" # TODO broken
sudo apt install -y git gitk python3-pip doxygen g++-multilib
sudo apt install -y cmake cmake-gui
sudo apt install -y dconf-editor
sudo apt install -y default-jre dotnet6

# Additional static analyzers
sudo apt install -y cppcheck iwyu
sudo pip install flawfinder # C++ lint
sudo pip install cpplint
sudo snap install codechecker
# TODO fb infer
# TODO cppdepend
# TODO protolint
# TODO PVS

# C++ package managers
sudo pip install conan

# Python packages
pip install matplotlib
pip install mock
pip install numpy
pip install pandas
pip install pytest
pip install requests
pip install scipy # TODO broken

# cleanup
sudo apt autoremove
sudo apt update
sudo apt -y upgrade
apt list --upgradable # check for the packages that were not upgraded
