#!/bin/bash
. ../../prelude.sh

# HOW TO WATCH GSettings changes on Ubuntu? Run `dconf watch /`
# NOTE: for_each blocks are sorted by path alphabetically (their content and blocks themselves)

# TODO toread: https://wiki.archlinux.org/title/GNOME
# https://wiki.archlinux.org/title/GNOME/Tips_and_tricks
# https://wiki.archlinux.org/title/GDM
# https://wiki.archlinux.org/title/GTK
# https://wiki.archlinux.org/title/GNOME/Files
# https://wiki.archlinux.org/title/GNOME_package_guidelines
# https://docs.gtk.org/gio/class.Settings.html
# https://docs.gtk.org/gio/class.Settings.html
# https://wiki.gnome.org/HowDoI/GSettings

# disable-lock-screen was set to true for some reason on my fresh Ubuntu 24.04 install
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.mutter dynamic-workspaces false

# Ptyxis and accent-color are not present on Ubuntu 24.04 - check and skip
# TODO remove the ifdef after Ubuntu 26.04 is avaliable is GitHub Actions runner
if gsettings get org.gnome.desktop.interface accent-color; then

    for_each "gsettings set org.gnome.Ptyxis " << 'BASH'
        restore-session "false"
        restore-window-size "false"
        scrollbar-policy "always"
BASH

    for_each "gsettings set org.gnome.desktop.calendar " << 'BASH'
        show-weekdate "true"
BASH

    for_each "gsettings set org.gnome.desktop.input-sources " << 'BASH'
        per-window true
        sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
        xkb-options "['terminate:ctrl_alt_bksp', 'shift:both_capslock', 'caps:escape']"
BASH

    for_each "gsettings set org.gnome.desktop.interface " << 'BASH'
        # WARNING: text-scaling-factor can break Chromium (or other GTK apps) and cause
        # the app window to increase in size on refocus (due to floating point rounding
        # errors). Always set the value to decimal that can be represented as float without
        # rounding error and also test whether the Chromium window does not change size on
        # refocus with the specific value.
        # TODO consider using 1 as scaling factor and setting interface/document/monospace fonts instead
        text-scaling-factor "1"
        # text-scaling-factor '1.1875' # this should also work - 1.0011 in binary
        font-name "Ubuntu Sans 14"
        document-font-name "Sans 13"
        monospace-font-name "Ubuntu Sans Mono 15"

        font-hinting "slight"
        cursor-size "64"

        enable-animations "false"

        accent-color "red"
        color-scheme "prefer-dark"
        gtk-theme "Yaru-red-dark"
        icon-theme "Yaru-red-dark"
BASH

fi # Ubuntu 24.04

for_each "gsettings set org.gnome.desktop.wm.preferences " << 'BASH'
    action-double-click-titlebar "toggle-maximize"
    action-middle-click-titlebar "lower" # 'minimize'
    auto-raise "true"
    button-layout "appmenu:minimize,close"
    focus-mode "sloppy"
    mouse-button-modifier "<Super>"
    num-workspaces "13"
    # NOTE: right click resizing is dependent on the sector of the window being
    # clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png
    resize-with-right-button "true"
    workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13']"
BASH
