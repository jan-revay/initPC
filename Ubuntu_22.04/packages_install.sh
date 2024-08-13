#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# TODO use lists for packages (and use on install command)
# TODO add XP-pen drivers installation to the script
# TODO add docker installation

. ../prelude.sh

# TODO - add all packages to a single list (change this to a conditional append)
if lspci | grep -i vmware; then                             # if the script is running inside of a VMware virtual machine
    sudo apt install -y open-vm-tools open-vm-tools-desktop # install "VMware tools" (drivers)
else                                                        # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify
    # sudo snap install zoom-client
    sudo apt install -y logiops
fi

. ../UbuntuCLI/packages_install.sh
# Programs with GUI are added below

# TODO add packages from PopOS here (and use this as a base for the PopOS)
# TODO make the script noninteractive
# TODO decide between flatpaks and snaps (or combine them)
# TODO VSC flatpak appears to be broken and lower quality than the snap
# TODO test the flatpaks
# TODO debloat
# TODO add snap installation script so that there is a same base on PopOS
# TODO consider removeing few `apt update`s
# Make flatpak packages install noninteractive
# consider installing all packages at once (config files would just add stuff
# to a list)
sudo apt update
sudo apt install -y linux-tools-common linux-tools-generic linux-tools-"$(uname -r)"
sudo apt update
sudo apt install -y flatpak meld kdevelop coqide gitk cmake-gui # editors, tools and IDEs


# TODO check this according to the official Docker documentation
# TODO make the install noninteractive
pushd /tmp
wget -O docker-desktop.deb 'https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64'
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt-get install ./docker-desktop.deb
popd

sudo apt install -y snapd
# TODO reloading bashrc might be needed
# Installing snaps from a list is not idempotent for some reason TODO try fixing
sudo snap install core
sudo snap install snap-store

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.visualstudio.code
# ===== MESSAGING, PRODUCTIVITY, GRAPHICS, SOUND AND BOOKS =====

sudo apt install -y gimp krita inkscape okular evince vlc audacity xdotool
sudo apt install -y ttf-mscorefonts-installer

# Flatpaks
flatpak install foliate signal caprine spotify

sudo snap install todoist

# ===== GUI TWEAKS AND AUTOMATIONS =====
sudo apt install -y dconf-editor gnome-tweaks

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
