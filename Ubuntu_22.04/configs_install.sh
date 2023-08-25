#!/bin/bash -x
# BASE IMAGE: Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# TODO sync with PopOS configs_install.sh

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# shellcheck source=/dev/null
. ../WSL_Ubuntu_22.04/configs_install.sh

# GNOME TWEAKS

# TODO add lower window on middle click
# TODO add keyboard settings
# TODO add fonts settings scaling factor

# KEYBOARD SHORTCUTS
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

# GSettings
# TODO describe the procedure of capturing the GSettings (Dconf monitor)
gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
gsettings set org.gnome.desktop.interface locate-pointer true
# todo test the keyboard settings
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"

# set default apps
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop application/x-shellscript
sudo update-alternatives --set editor /usr/bin/nvim
