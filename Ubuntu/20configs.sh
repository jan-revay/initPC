#!/bin/bash
. ../prelude.sh

# The script should not require any user input and should be idempotent.

# Workflow: use `dconf watch /`, make the change via GUI,
# use `gsettings get` to check the path, use `gsettings set` to verify the setting
# add the line here...

# TODO sync with PopOS configs_install.sh
# TODO move this to DistroAgnostic folder (this is not OS specific but just
# GNOME specific)
# TODO add command to set GNOME terminal tab close keybinding to Ctrl+W
# TODO consider using dconf dump & dconf load instead of calling gsettings for every key
# see: https://askubuntu.com/questions/984205/how-to-save-gnome-settings-in-a-file

# TODO - try to use lists where possible...

# TODO pohrat sa s tymi nastaveniami, ci vlastne su vsetky potrebne a robia to co chcem

# GNOME TWEAKS

# TODO add keyboard settings
# TODO add fonts settings scaling factor
# TODO add grup timeout setup to 1
# TODO add setup of Ubuntu tiling assistant GNOME extension (gaps, highlight
# the active window...).
# TODO normalise '' and " usage and also usage without " or '
# TODO - conflict with Ubuntu settings multitasking tab and gsettings (dash-to-dock and tiling manager...)

# TOREAD:
# - https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/desktop_migration_and_administration_guide/configuration-overview-gsettings-dconf

if ! sudo prime-select nvidia; then
    echo -e "${RED}WARNING: prime-select not found ${NC}"
fi

# TODO design and add all keybindings
# TODO remove useless wm keybindings
# TODO make the keybindings work similar to AltSnap on windows (emulate AltSnap)
# TODO have a look what keybindings do other developers use for
# switching desktops and window navigation/tiling

# KEYBOARD SHORTCUTS (keybindings)
# note: the keyboard shortcuts are designed to behave the same regardless of the
# keyboard layout (EN or SK).
# TODO add a custom keybinding for gnome-system-monitor (ctrl+shift+esc)
# https://community.linuxmint.com/tutorial/view/1171
# and make sure that the process is idempotent

# gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Alt>s']"
# NOTE: <Alt>s is in confict with MS whiteboard shortcuts

# TODO - maybe add this where extensions are installed
# TODO add line breaks
# TODO consider direct dconf backup/restore instead
# https://ostechnix.com/backup-and-restore-linux-desktop-system-settings-with-dconf/

# TODO - add a TODOist keybinding
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
#   ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding
#   '<Shift><Super>q'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command
#   'todoist'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name
#   'Todoist'

# TODO add tiling-assistant keybindings

# /org/gnome/shell/extensions/auto-move-windows/application-list
# ['org.gnome.Nautilus.desktop:3', 'com.sindresorhus.Caprine.desktop:4', 'snap-store_snap-store.desktop:7', 'gparted.desktop:7', 'code.desktop:2', 'chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Profile_3.desktop:4', 'org.signal.Signal.desktop:4', 'chrome-hpfldicfbfomlpcikngkocigghgafkph-Profile_3.desktop:4', 'gnome-session-properties.desktop:7', 'nvidia-settings.desktop:7', 'update-manager.desktop:7', 'org.gnome.tweaks.desktop:7', 'gnome-system-panel.desktop:7', 'org.gnome.SystemMonitor.desktop:7', 'software-properties-gtk.desktop:7', 'gnome-printers-panel.desktop:7', 'org.gnome.baobab.desktop:7', 'chrome-bbdeiblfgdokhlblpgeaokenkfknecgl-Profile_3.desktop:4']
# /org/gnome/desktop/interface/enable-animations  false
# /org/gnome/shell/extensions/tilingshell/overridden-settings
#  '{"org.gnome.mutter":{"edge-tiling":"false"}}'

# TODO - does not work for some reason...
# for profile in $(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[],'"); do
# profile_path="/org/gnome/Terminal/Legacy/Profiles:/:$profile/"
# gsettings set "org.gnome.Terminal.Legacy.Profile:$profile_path" scrollback-lines 500000
# done

# TODO - keybindings - tostudy
# What is the difference between "Switch applications", "Switch windows",
# "Switch windows directly", "Switch windows of an application", and
# "Switch windows of an app directly" keybindings? Learn how to use them...
# (see GNOME settings)

# set default apps
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop application/x-shellscript

if ! sudo update-alternatives --set editor /usr/bin/nvim; then
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 100
    sudo update-alternatives --set editor /usr/bin/nvim
fi

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
