#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# TODO use lists for packages (and use on install command)
# TODO add XP-pen drivers installation to the script
# TODO add docker installation
# TODO install packages via a list...

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
if lspci | grep -i vmware; then                             # if the script is running inside of a VMware virtual machine
    sudo apt install -y open-vm-tools open-vm-tools-desktop # install "VMware tools" (drivers)
else                                                        # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify TODO
    # sudo snap install zoom-client TODO
    sudo apt install -y logiops
fi

readonly APT_GUI_PACKAGES=(
    # ===== package managers =====
    snapd flatpak

    # I don't remember why this is here (TODO review)
    linux-tools-common linux-tools-generic linux-tools-"$(uname -r)"

    # ===== Editors, tools and IDEs =====
    meld kdevelop coqide gitk cmake-gui

    # ===== MESSAGING, PRODUCTIVITY, GRAPHICS, SOUND AND BOOKS =====
    gimp krita inkscape okular evince vlc audacity xdotool
    ttf-mscorefonts-installer

    # ===== GUI TWEAKS AND AUTOMATION =====
    dconf-editor gnome-tweaks

    # ===== CODING =====
    sqlitebrowser

    # ===== TO TRY ===== (TODO review)
    actiona # automations, written in C++ https://github.com/Jmgr/actiona
    autokey-common autokey-gtk
)

time sudo apt-get install -y "${APT_GUI_PACKAGES[@]}"

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
