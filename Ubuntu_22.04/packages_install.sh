#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# TODO use lists for packages (and use on install command)
# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

if lspci | grep -i vmware; then                             # if the script is running inside of a VMware virtual machine
    sudo apt install -y open-vm-tools open-vm-tools-desktop # install "VMware tools" (drivers)
else                                                        # we are running bare metal (I don't use VirtualBox or other hypervisors)
    # sudo snap install spotify
    # sudo snap install zoom-client
    sudo apt install -y logiops
fi

# WSL Ubuntu script installs command line applications
# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/packages_install.sh
# Programs with GUI are added below

# TODO add packages from PopOS here (and use this as a base for the PopOS)
# TODO make the script noninteractive
sudo apt install -y linux-tools-common linux-tools-generic linux-tools-"$(uname -r)"

sudo apt install -y flatpak meld kdevelop coqide gitk cmake-gui # editors, tools and IDEs

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.visualstudio.code
# ===== MESSAGING, PRODUCTIVITY, GRAPHICS, SOUND AND BOOKS =====

sudo apt install -y gimp krita inkscape okular evince vlc audacity xdotool
sudo apt install -y ttf-mscorefonts-installer

# Flatpaks
flatpak install foliate todoist signal caprine

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
