#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL
# TODO move the package lists to external files

. ../prelude.sh

export DEBIAN_FRONTEND=noninteractive
# TODO "Which services should be restarted?" prompt is still present in VM
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

sudo apt-get -y update
time sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# see: https://github.com/jan-revay/initPC/issues/31
touch ~/.bashrc # some install scripts want to append stuff here

# sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test # repository with latest GCC
LATEST_GCC_VER_IN_APT=$(apt-cache search --names-only '^gcc-[0-9][0-9]$' \
    | grep -E -o '^gcc-[0-9][0-9]' | sort -r | head --lines 1 | grep -E -o '[0-9][0-9]')

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
# TODO consider moving all packages that need GUI to GUI part of the initPC script
readonly APT_PACKAGES=(
    # GCC and build tools
    build-essential gdb rr ccache ninja-build cmake cmake-gui
    gcc-"${LATEST_GCC_VER_IN_APT}" g++-"${LATEST_GCC_VER_IN_APT}"

    # " linux-tools-$(uname -r)" # TODO broken

    # editors
    # TODO consider moving qtcreator to the GUI part of the script
    neovim emacs qtcreator

    # utils
    ripgrep tree curl neofetch htop tmux at zsh traceroute jq
    # NOTE: fd-find executable is called `fdfind`
    # TODO consider moving doconf-editor to GUI part of the initPC script
    dconf-editor doxygen git gh bat exa man fish fd-find

    # package managers
    npm rubygems pipx python3-pip
    # TODO maybe add default-jre and dotnet7?

    # static analyzers
    # TODO clazy is broken on Debian:testing
    cppcheck cppcheck-gui iwyu clazy shellcheck

    # code formatters
    cmake-format shfmt

    # dynamic analyzers , TODO test them
    valgrind hotspot heaptrack

    # Python packages
    python3-matplotlib python3-mock python3-numpy python3-pandas
    python3-pytest python3-requests python3-scipy python3-pylsp

    # requirements for llvm and rust install scripts
    wget lsb-release software-properties-common gnupg curl
)

time sudo apt-get install -y "${APT_PACKAGES[@]}"

# Install the most recent llvm (see https://apt.llvm.org/)
pushd /tmp || exit ${EXIT_FILE_IO_ERROR}
# packages required by llvm.sh script are installed above
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
if ! time yes '' | sudo ./llvm.sh all; then
    # workaround bug in llvm install script: https://github.com/llvm/llvm-project/issues/62475
    sudo apt update -y
    time yes '' | sudo ./llvm.sh all
fi
rm llvm.sh
popd || exit ${EXIT_FILE_IO_ERROR}

# Install rust ecosystem
time curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# cleanup
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
apt list --upgradable # check for the packages that were not upgraded

# === PYTHON APPLICATIONS ===
# pipx ensurepath - ensurepath is broken (it adds the path multiple times in subshells)

# Static analyzers
# codechecker disabled as it fails: pip seemed to fail to build package: PyYAML==5.4.1
# pipx install codechecker
pipx install flawfinder
pipx install cpplint
# TODO add fb_infer, cppdepend, protolint, PVS...

# C++ package managers
pipx install conan

# === Rust packages ===
# shellcheck source=/dev/null
source "$HOME/.cargo/env"
# TODO try to find these packages in apt db or as snaps
# TODO try to minimize the number of package managers I need to use
# TODO installing cargo packages is super slow - try to find another way. Don't use cargo unless we have to.
# NOTE: du-dust and procs are also available at snap store, tokei is not (TODO remove?)
CARGO_PACKAGES=(tokei git-graph)
time cargo install "${CARGO_PACKAGES[@]}"

# NPM packages
time sudo npm i -g bash-language-server

# TODO remove is not used (also with GEM)
# GEM packages
time sudo gem install mdl # markdown-lint
