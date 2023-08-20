#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test # repository with latest GCC
LATEST_GCC_VER_IN_APT=$(apt-cache search --names-only '^gcc-[0-9][0-9]$' |
    grep -E -o '^gcc-[0-9][0-9]' | sort -r | head --lines 1 | grep -E -o '[0-9][0-9]')

# Install the most recent llvm (see https://apt.llvm.org/)
pushd /tmp || exit
# llvm.sh required packages
sudo apt-get install -y wget lsb-release software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
yes '' | sudo ./llvm.sh all
rm llvm.sh
popd || exit

# Install rust ecosystem
sudo apt-get install curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
APT_PACKAGES=(build-essential gdb rr ccache ninja-build cmake cmake-gui) # GCC and build tools
APT_PACKAGES+=(gcc-"${LATEST_GCC_VER_IN_APT}")                           # latest GCC
APT_PACKAGES+=(g++-"${LATEST_GCC_VER_IN_APT}")                           # latest g++

# APT_PACKAGES+=" linux-tools-$(uname -r)" # TODO broken
APT_PACKAGES+=(neovim emacs qtcreator)                                    # editors
APT_PACKAGES+=(ripgrep tree curl neofetch htop tmux at zsh traceroute jq) # utils
APT_PACKAGES+=(dconf-editor doxygen git gh bat exa man fish fd-find)      # utils
APT_PACKAGES+=(npm)                                                       # package managers
# NOTE: fd-find executable is called `fdfind`
APT_PACKAGES+=(python3-pip) # various runtimes
# TODO maybe add default-jre and dotnet7?
APT_PACKAGES+=(cppcheck cppcheck-gui iwyu clazy)                             # static analyzers
APT_PACKAGES+=(cmake-format shfmt)                                           # code formatters
APT_PACKAGES+=(valgrind hotspot heaptrack)                                   # dynamic analyzers , TODO test them
APT_PACKAGES+=(python3-matplotlib python3-mock python3-numpy python3-pandas) # Python packages
APT_PACKAGES+=(python3-pytest python3-requests python3-scipy python3-pylsp)  # Python packages
sudo apt-get install -y "${APT_PACKAGES[@]}"

# cleanup
sudo apt-get autoremove
sudo apt-get update
sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# === PYTHON APPLICATIONS ===
sudo apt-get install -y pipx
pipx ensurepath

# Static analyzers
# codechecker disabled as it fails: pip seemed to fail to build package: PyYAML==5.4.1
# pipx install codechecker
pipx install flawfinder
pipx install cpplint
# TODO add fb_infer, cppdepend, protolint, PVS...

# C++ package managers
pipx install conan

# === Rust packages ===
# /home/jr/.cargo/bin is added to the path in .bashrc (and other rc files)
source "$HOME/.cargo/env"
cargo install tokei
cargo install du-dust
cargo install procs

# NPM packages
sudo npm i -g bash-language-server

# bare dpkg packages
wget https://github.com/o2sh/onefetch/releases/download/2.18.1/onefetch_2.18.1_amd64.deb
dpkg -i onefetch_2.18.1_amd64.deb
# TODO delete the package after inastall (and save it to /tmp)
