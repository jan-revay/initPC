#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# Workflow: use `dconf watch /`, make the change via GUI,
# use `gsettings get` to check the path, use `gsettings set` to verify the setting
# add the line here...

# TODO sync with PopOS configs_install.sh
# TODO move this to CommonInitScripts folder (this is not OS specific but just
# GNOME specific)
# TODO add command to set GNOME terminal tab close keybinding to Ctrl+W

. ../prelude.sh

. ../UbuntuCLI/configs_install.sh

# GNOME TWEAKS

# TODO add keyboard settings
# TODO add fonts settings scaling factor
# TODO add grup timeout setup to 1
# TODO add setup of Ubuntu tiling assistant GNOME extension (gaps, highlight
# the active window...).

# TOREAD:
# - https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/desktop_migration_and_administration_guide/configuration-overview-gsettings-dconf

# KEYBOARD SHORTCUTS
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

# GSettings
# TODO describe the procedure of capturing the GSettings (Dconf monitor)
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red'
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 8
gsettings set org.gnome.desktop.wm.preferences workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9']"

# TODO add descriptions to these settings in comments (via ChatGPT)

if bash -c '. ../prelude.sh; distro_version_ge 23' &> /dev/null; then
    gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true
    gsettings set org.gnome.shell.extensions.dash-to-dock default-windows-preview-to-open true
fi
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time '0.01'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold '70.0'
gsettings set org.gnome.shell.extensions.dash-to-dock preview-size-scale '0.25'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-timeout '4'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true

gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
gsettings set org.gnome.desktop.interface cursor-size 64

gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'
# NOTE: right click resizing is dependent on the sector of the window being
# clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true

# TODO design and add all keybindings
# TODO remove useless wm keybindings
# TODO make the keybindings work similar to AltSnap on windows (emulate AltSnap)
# Keybindings
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Control><Alt><Super>h']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Control><Alt><Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Control><Alt><Super>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Control><Alt><Super>l']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Control><Alt><Super>semicolon']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Control><Alt><Super>apostrophe']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Control><Alt><Super>Return']"
gsettings set org.gnome.desktop.wm.keybindings always-on-top "['<Control><Alt><Super>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"

# set default apps
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop application/x-shellscript
sudo update-alternatives --set editor /usr/bin/nvim

# TODOs:
# Add - add slovak qwerty keyboard layout
# set workspaces to static and number to 6
# set to dark theme
# add logid.cfg (logitech mouse) options copy paste (and add the logid file
# to the dotfiles repo)
#
#
# TODO - finish keyboard setup
# https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#One-click_key_functions
# e.g. swap esc and caps lock
# https://www.reddit.com/r/vim/comments/k5twce/switching_esc_with_caps_lock/
#
# https://www.baeldung.com/linux/vim-switch-back-normal-mode-options
# https://www.reddit.com/r/vim/comments/shndya/how_do_you_escape_to_normal_mode/

pushd RootDotfiles/
sudo stow -vvv --target=/ disable_highres_scroll/

if stow -vvv --no --target=/ MX3_MASTER_LOGID_CONFIG/; then
    sudo stow -vvv --target=/ MX3_MASTER_LOGID_CONFIG/
else
    sudo mv /etc/logid.cfg /etc/logid.cfg-initPCBackup"$(date '+%Y%m%d_%H%M%S')"
    sudo stow -vvv --target=/ MX3_MASTER_LOGID_CONFIG/
fi
popd
