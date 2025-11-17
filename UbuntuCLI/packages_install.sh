#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL
# TODO move the package lists to external files
# TODO add repos and packates that PopOS has: https://pop.system76.com/
. ../prelude.sh

export DEBIAN_FRONTEND=noninteractive
# TODO "Which services should be restarted?" prompt is still present in VM
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

time sudo apt-get -y update
time sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# see: https://github.com/jan-revay/initPC/issues/31
touch ~/.bashrc # some install scripts want to append stuff here

# Why?: some packages need postfix and try to install it as a dependence
# and then freeze the installation because postfix install script shows
# an interactive menu.
# Preconfigure Postfix to select "Local only" and set the address to localhost
# TODO find out which packages have postfix as a dependency ant maybe try to remove
# the dependency in the future?
# TODO check - only adding the answers to debconf so that the installation is
# not interrupted if a package has postfix as its dependence.
echo "postfix postfix/mailname string localhost" | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type select Local only" | sudo debconf-set-selections

# sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test # repository with latest GCC
LATEST_GCC_VER_IN_APT=$(apt-cache search --names-only '^gcc-[0-9][0-9]$' \
    | grep -E -o '^gcc-[0-9][0-9]' | sort -r | head --lines 1 | grep -E -o '[0-9][0-9]')

# see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
# TODO consider moving all packages that need GUI to GUI part of the initPC script
# TODO add rclone
APT_PACKAGES=(
    # GCC and build tools
    build-essential make gdb rr ccache ninja-build cmake cmake-gui
    gcc-"${LATEST_GCC_VER_IN_APT}" g++-"${LATEST_GCC_VER_IN_APT}"

    # " linux-tools-$(uname -r)" # TODO broken

    # editors
    # TODO consider moving qtcreator to the GUI part of the script
    neovim emacs hexedit
    wl-clipboard # copy/paste to/from nvim

    # utils
    ripgrep tree curl
    # neofetch

    htop tmux at zsh traceroute jq stow

    diffoscope
    # NOTE: fd-find executable is called `fdfind`
    # TODO consider moving doconf-editor to GUI part of the initPC script
    dconf-editor doxygen git gh bat man fish fd-find
    fzf # TODO learn how to use fzf and add aliases
    # tldr # TODO learn how to use
    libcrack2
    flex # fast lexical analyzer generator
    nvme-cli fio

    # package managers
    npm rubygems pipx python3-pip
    # TODO maybe add default-jre and dotnet7?

    # static analyzers
    # TODO clazy is broken on Debian:testing
    cppcheck cppcheck-gui iwyu shellcheck
    cloc

    # code formatters
    cmake-format shfmt

    # dynamic analyzers , TODO test them
    valgrind

    # Python packages
    python3-matplotlib python3-mock python3-numpy python3-pandas
    python3-pytest python3-requests python3-scipy python3-pylsp

    # requirements for llvm and rust install scripts
    wget lsb-release gnupg curl

    # stress testing
    stress # see: https://github.com/resurrecting-open-source-projects/stress
    # TODO add more stress testing utilities

    # utilities
    7zip zip file rsync openssh-client
)

# exa was replaced by eza on later versions of Ubuntu
# (exa is no longer maintained)
if bash -c '. ../prelude.sh; distro_version_le 23' &> /dev/null; then
    APT_PACKAGES+=('exa')
else
    APT_PACKAGES+=('eza')
fi

# Kali and Debian testing do not have these packages...
# TODO try a more elegant fix
if bash -c '. ../prelude.sh; distro_is ubuntu || (distro_is debian && distro_version_le 12)' &> /dev/null; then
    APT_PACKAGES+=(clazy heaptrack software-properties-common)
fi

time sudo apt-get install -y "${APT_PACKAGES[@]}"

# TODO add else branch for other distros
# The LLVM convenience script does not work with Debian testing and Kali
# if bash -c '. ../prelude.sh; distro_is ubuntu || (distro_is debian && distro_version_le 12)' &> /dev/null; then
#     # Install the most recent llvm (see https://apt.llvm.org/)
#     pushd /tmp || exit "${EXIT_FILE_IO_ERROR}"
#     # packages required by llvm.sh script are installed above
#     wget https://apt.llvm.org/llvm.sh
#     chmod +x llvm.sh
#     if ! time yes '' | sudo ./llvm.sh all; then
#         # workaround bug in llvm install script: https://github.com/llvm/llvm-project/issues/62475
#         # TODO remove the workaround when it is fixed in llvm.sh
#         sudo apt update -y
#         time yes '' | sudo ./llvm.sh all
#     fi
#     rm llvm.sh
#     popd || exit "${EXIT_FILE_IO_ERROR}"
# fi

# Install rust ecosystem
time curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# cleanup
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
apt list --upgradable # check for the packages that were not upgraded

# === PYTHON APPLICATIONS ===
# Static analyzers
# codechecker disabled as it fails: pip seemed to fail to build package: PyYAML==5.4.1
# pipx install codechecker

readonly PIPX_PACKAGES=(
    flawfinder cpplint conan
)
# TODO add fb_infer, cppdepend, protolint, PVS...

time print0 "${PIPX_PACKAGES[@]}" | xargs -0 -I % pipx install %

# pipx ensurepath - ensurepath is broken (it adds the path multiple times in subshells)
# TODO - is the ensurepath still broken? I think so as it adds the path indefinitely... -- TODO test
# in one place
if ! echo "$PATH" | grep /home/jr/.local/bin; then
    pipx ensurepath
    # shellcheck source=/dev/null
    source ~/.bashrc
    # TODO the source command was not enough for come reason... investigate!!!
    export PATH="$PATH:/home/jr/.local/bin"
fi

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
# TODO uncomment and fix the next line
# time sudo gem install github-linguist

# TODO add automatic pipx upgrade via pipx
# pipx install pipx
# And optional remove the obsolete apt pipx!
# sudo apt purge --autoremove pipx
# https://github.com/pypa/pipx/issues/1481
