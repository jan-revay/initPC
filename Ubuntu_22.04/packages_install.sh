#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# TODO use lists for packages (and use on install command)
# TODO add XP-pen drivers installation to the script
# TODO add docker installation
# TODO install packages via a list...
# TODO consider adding pavucontrol
# TODO add nix package manager + start managing more packages via nix

. ../prelude.sh

. ../UbuntuCLI/packages_install.sh

export DEBIAN_FRONTEND=noninteractive
# TODO "Which services should be restarted?" prompt is still present in VM
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

time sudo apt-get -y update
time sudo apt-get -y upgrade
apt list --upgradable # check for the packages that were not upgraded

# TODO - add all packages to a single list (change this to a conditional append)
if lspci | grep -i vmware; then                                 # if the script is running inside of a VMware virtual machine
    sudo apt-get install -y open-vm-tools open-vm-tools-desktop # install "VMware tools" (drivers)
else                                                            # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify TODO
    # sudo snap install zoom-client TODO
    sudo apt-get install -y logiops
fi

# TODO try to install chrome in a more standard way
mkdir -p ~/tmp
pushd ~/tmp

# Install Google Chrome and Chrome extension for managing GNOME extensions
sudo apt-get install -y wget gpg
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > linux_signing_key.pub
# sudo install -D -o root -g root -m 644 linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub
# sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" \
#    > /etc/apt/sources.list.d/google-chrome.list'
# sudo apt-get -y update
# sudo apt-get install -y google-chrome-stable chrome-gnome-shell
# rm linux_signing_key.pub

# TODO fix VSC and Google chrome installation
# Install VSC (Snap package is problematic for C++ because of issues with libraries)
# echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
# | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
# rm -f packages.microsoft.gpg

sudo apt-get install -y apt-transport-https
sudo apt-get -y update
# sudo apt-get install -y code # or code-insiders
popd

echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
    | sudo debconf-set-selections

curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt-get -y update
sudo apt-get -y install wezterm

# TODO add kitty terminal emulator
# TODO add IDA disassembler for Linux <https://letsdefend.io/blog/how-to-install-ida-on-linux>
readonly APT_GUI_PACKAGES=(
    # ===== package managers =====
    snapd flatpak

    # ===== needed by Another Window Session Manager GNOME extension =====
    # TODO remove if not used resp. remove packages that are not necessary
    # TODO add setup according to https://github.com/nlpsuge/gnome-shell-extension-another-window-session-manager?tab=readme-ov-file#how-to-make-close-by-rules-work or remove
    ydotool # window management utility
    procps
    libglib2.0-dev
    libgtop2-dev
    gir1.2-gtop-2.0 # gir1.2-gtop-2.0 is needed by some performance monitoring GNOME extensions

    # I don't remember why this is here (TODO review)
    linux-tools-common linux-tools-generic linux-tools-"$(uname -r)"

    # ===== Editors, tools and IDEs =====
    # TODO gitk and git-gui break the install script (dependencies) - choose another install method
    # it is just a bash script, hence it might make sense to install from source
    meld kdevelop coqide qgit cmake-gui # gitk git-gui
    qtcreator
    kitty alacritty

    # ===== FILES AND DISK MANAGEMENT
    gparted

    # ===== FONTS ====
    ttf-mscorefonts-installer

    # ===== MESSAGING, PRODUCTIVITY, GRAPHICS, SOUND AND BOOKS =====
    gimp krita inkscape okular evince vlc audacity xdotool
    shutter # TODO learn how to use efficiently resp. remove if unused

    # ===== GUI TWEAKS AND AUTOMATION =====
    dconf-editor gnome-tweaks gnome-shell-extension-manager

    # ===== CODING =====
    sqlitebrowser

    # ===== MULTIMEDIA =====
    obs-studio handbrake handbrake-cli ffmpeg x264

    # ===== TO TRY ===== (TODO review)
    actiona # automations, written in C++ https://github.com/Jmgr/actiona
    autokey-common autokey-gtk

    ubuntu-restricted-extras

    chrome-gnome-shell gnome-browser-connector # installing extensions from Firefox or Chrome

)

# TODO alacritty is not present on Ubuntu releases older than Ubuntu 24.04
if bash -c '. ../prelude.sh; distro_version_le 24' &> /dev/null; then
    APT_PACKAGES+=('')
else
    APT_PACKAGES+=('alacritty')
fi

time sudo apt-get install -y "${APT_GUI_PACKAGES[@]}"

pipx install gnome-extensions-cli --system-site-packages

# TODO add packages from PopOS here (and use this as a base for the PopOS)
# TODO make the script noninteractive

# TODO debloat
# TODO add snap installation script so that there is a same base on PopOS
# TODO consider removing few `apt update`s
# consider installing all packages at once (config files would just add stuff
# to a list)

# TODO check this according to the official Docker documentation
# TODO make the install noninteractive
# TODO do I want to install Docker desktop app or just the CLI (Docker engine)
# TODO this install script was broken - repair
# pushd /tmp
# wget -O docker-desktop.deb 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64'
# sudo apt install -y ca-certificates curl gnupg lsb-release
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt update -y
# sudo apt-get install ./docker-desktop.deb
# popd

# cleanup
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
apt list --upgradable # check for the packages that were not upgraded

. ../CommonInitScripts/flatpaks_snaps_appimages_nix.sh
