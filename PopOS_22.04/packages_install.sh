#!/bin/bash -x
# BASE IMAGE: PopOS 22.04

# TODO
# - Docker
# - ASP solver (e.g. with Datalog syntax)
# - go through the flatpack and PopOS store and install the relevant stuff
# - remove google chrome tray icon?
# - order and tidy the tray icons
# - go through the backed up directories and packages form the IMS laptop and install relevant stuff
# - set up the mouse
# - split the packages into essential (basically the ones from WSL) and optional
# - test & tune this on a virtual machine so that no user input is required

export PS4="\[\033[1;93m\]+ \[\033[0m\]"
readonly LLVM_VERSION=16  # CURRENT_LLVM_STABLE
readonly GCC_VERSION=13  # CURRENT_GCC_STABLE

sudo apt update
sudo apt upgrade
flatpak update

if lspci | grep -i vmware; then  # if the script is running inside of a VMware virtual machine
    sudo apt install -y open-vm-tools open-vm-tools-desktop  # install "VMware tools" (drivers)
else # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify
    # sudo snap install zoom-client
    sudo apt install -y logiops
fi

# ===== COMPILERS, DEBUGGERS, BUILD SYSTEMS, PACKAGE MANAGERS AND RUNTIMES ===== 

# Clang
sudo apt install -y clang-${LLVM_VERSION} lldb-${LLVM_VERSION} lld-${LLVM_VERSION} \
    clangd-${LLVM_VERSION} clang-tidy-${LLVM_VERSION} clang-format-${LLVM_VERSION} \
    clang-tools-${LLVM_VERSION} llvm-${LLVM_VERSION}-dev lld-${LLVM_VERSION} \
    llvm-${LLVM_VERSION}-tools libomp-${LLVM_VERSION}-dev libc++-${LLVM_VERSION}-dev \
    lldb-${LLVM_VERSION} libc++abi-${LLVM_VERSION}-dev libclang-common-${LLVM_VERSION}-dev \
    libclang-${LLVM_VERSION}-dev libclang-cpp${LLVM_VERSION}-dev libunwind-${LLVM_VERSION}-dev

# @note latest GCC should already be installed in the PopOS_22.04 image
# @note rustc in PopOS_22.04 image is recent enough (a few months old)
# ad rr see https://github.com/rr-debugger/rr/wiki/Using-rr-in-an-IDE
sudo apt install -y gcc-${GCC_VERSION} rr rustc gprolog haskell-platform coq \
    default-jre dotnet6
sudo apt install -y make build-essential ccache ninja-build
sudo apt install -y linux-tools-common linux-tools-generic linux-tools-"$(uname -r)"

# programming tools
sudo apt install -y code vim neovim emacs meld qtcreator kdevelop coqide  # editors, tools and IDEs
# TODO remove need for user interaction (Y - enter)
flatpak install clion postman dfeet                                       # editors, tools and IDEs (flatpak)
sudo apt install -y git gitk doxygen g++-multilib qt6-base-dev
sudo apt install -y cmake cmake-gui

# misc tools
sudo apt install -y google-chrome-stable ripgrep xdotool tree curl neofetch htop tmux at zsh traceroute jq

# static analyzers and package managers
sudo apt install -y python3-pip
sudo pip install conan
sudo apt install -y cppcheck iwyu
sudo pip install flawfinder # C++ linter
sudo pip install cpplint
# TODO sudo snap install codechecker
# TODO fb infer
# TODO cppdepend
# TODO protolint
# TODO PVS

# ===== MESSAGING, PRODUCTIVITY, GRAPHICS, SOUND AND BOOKS =====

sudo apt install -y gimp krita inkscape okular evince vlc audacity
sudo apt install -y ttf-mscorefonts-installer

# Flatpaks
flatpak install foliate todoist signal caprine

# ===== GUI TWEAKS AND AUTOMATIONS ===== 
sudo apt install -y dconf-editor gnome-tweaks

# ===== PYTHON LIBRARIES =====

# @warning installing the libraries globally might not be the best idea
sudo pip install scikit-image
sudo pip install docutils
sudo pip install matplotlib
sudo pip install pytest
sudo pip install numpy
sudo pip install jira
sudo pip install tabulate

pip install bitarray
pip install bson
pip install h5py
pip install hypothesis
pip install jinja2
pip install log4mongo
pip install lxml
pip install mock
pip install pandas
pip install Pillow
pip installl quantities
pip install pyyaml
pip install quantities
pip install requests
pip install scipy

# ===== GNOME EXTENSIONS =====

# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extesions via Chrome/Firefox plugin)
# @note the gdbus call InstallRemoteExtension() is invoked twice twice as sometimes the first call fails

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "scroll-workspaces@gfxmonk.net"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "workspaces-bar@fthx"


sudo apt install -y gnome-shell-extension-manager gir1.2-gtop-2.0 lm-sensors # vitals monitor needs that
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "Vitals@CoreCoding.com"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension "hide-universal-access@akiirui.github.io"

gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
gdbus call --session --dest org.gnome.Shell.Extensions --object-path \
    /org/gnome/Shell/Extensions --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    "auto-move-windows@gnome-shell-extensions.gcampax.github.com"

# TODO Gnome extensions to try
# - some new clipboard manager

# ===== MAYBE UNUSED =====
# TODO remove need for user interaction (Y - enter)
flatpak install gitkraken
sudo apt install -y sqlitebrowser

# ==== TO TRY ====
sudo apt install -y actiona # automations, written in C++ https://github.com/Jmgr/actiona
sudo apt install -y autokey-common autokey-gtk

# cleanup
sudo apt autoremove
apt list --upgradable # check for the packages that were not upgraded
