#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# User input required: a single keypress during the LLVM install (beginning), otherwise silent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL

export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

sudo apt update
sudo apt -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# Install the most recent llvm (see https://apt.llvm.org/)
pushd /tmp || exit
# llvm.sh required packages
sudo apt install -y wget lsb-release wget software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh all
rm llvm.sh
popd || exit

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
APT_PACKAGES="build-essential rr ccache ninja-build cmake cmake-gui cmake-format" # GCC and build tools
# APT_PACKAGES+=" linux-tools-$(uname -r)" # TODO broken

APT_PACKAGES+=" neovim emacs qtcreator" # editors
APT_PACKAGES+=" ripgrep tree curl neofetch htop tmux at zsh traceroute jq" # utils1
APT_PACKAGES+=" dconf-editor doxygen git" # utils2
APT_PACKAGES+=" python3-pip" # various runtimes
# TODO maybe add default-jre and dotnet7?

APT_PACKAGES+=" cppcheck cppcheck-gui iwyu clazy" # Static analyzers

APT_PACKAGES+=" valgrind" # Dynamic analyzers

# Python packages
APT_PACKAGES+=" python3-matplotlib python3-mock python3-numpy python3-pandas"
APT_PACKAGES+=" python3-pytest python3-requests python3-scipy"
sudo apt install -y ${APT_PACKAGES}

# cleanup
sudo apt autoremove
sudo apt update
sudo apt -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# === PYTHON APPLICATIONS ====
sudo apt install -y pipx
pipx ensurepath

# Static analyzers
pipx install codechecker
pipx install flawfinder
pipx install cpplint
# TODO add fb_infer, cppdepend, protolint, PVS...

# C++ package managers
pipx install conan
