#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL

export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# LATEST_GCC_VER="13"
# sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test # repository with latest GCC

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# Install the most recent llvm (see https://apt.llvm.org/)
pushd /tmp || exit
# llvm.sh required packages
sudo apt-get install -y wget lsb-release wget software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
yes '' | sudo ./llvm.sh all
rm llvm.sh
popd || exit

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
APT_PACKAGES=(build-essential rr ccache ninja-build cmake cmake-gui) # GCC and build tools
# APT_PACKAGES+=(gcc-${LATEST_GCC_VER} g++-${LATEST_GCC_VER} gdb) # latest GCC
# APT_PACKAGES+=" linux-tools-$(uname -r)" # TODO broken
APT_PACKAGES+=(neovim emacs qtcreator) # editors
APT_PACKAGES+=(ripgrep tree curl neofetch htop tmux at zsh traceroute jq) # utils
APT_PACKAGES+=(dconf-editor doxygen git gh bat) # utils
APT_PACKAGES+=(python3-pip) # various runtimes
# TODO maybe add default-jre and dotnet7?
APT_PACKAGES+=(cppcheck cppcheck-gui iwyu clazy) # static analyzers
APT_PACKAGES+=(cmake-format shfmt) # code formatters
APT_PACKAGES+=(valgrind hotspot heaptrack) # dynamic analyzers , TODO test them
APT_PACKAGES+=(python3-matplotlib python3-mock python3-numpy python3-pandas) # Python packages
APT_PACKAGES+=(python3-pytest python3-requests python3-scipy) # Python packages
sudo apt-get install -y "${APT_PACKAGES[@]}"

# cleanup
sudo apt-get autoremove
sudo apt-get update
sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# === PYTHON APPLICATIONS ====
sudo apt-get install -y pipx
pipx ensurepath

# Static analyzers
pipx install codechecker
pipx install flawfinder
pipx install cpplint
# TODO add fb_infer, cppdepend, protolint, PVS...

# C++ package managers
pipx install conan
