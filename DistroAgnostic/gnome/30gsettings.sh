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
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

# Ptyxis and accent-color are not present on Ubuntu 24.04 - check and skip
# TODO remove the ifdef after Ubuntu 26.04 is avaliable is GitHub Actions runner
if gsettings get org.gnome.Ptyxis scrollbar-policy && gsettings get org.gnome.desktop.interface accent-color; then

    for_each "gsettings set org.gnome.Ptyxis " << 'BASH'
        restore-session "false"
        restore-window-size "false"
        scrollbar-policy "always"
BASH

    for_each "gsettings set org.gnome.Ptyxis.Shortcuts " << 'BASH'
        close-tab "<Control>w"
        move-next-tab "<Control>Tab"
        move-previous-tab "<Shift><Control>Tab"
        focus-tab-1 "<Control>1"
        focus-tab-2 "<Control>2"
        focus-tab-3 "<Control>3"
        focus-tab-4 "<Control>4"
        focus-tab-5 "<Control>5"
        focus-tab-6 "<Control>6"
        focus-tab-7 "<Control>7"
        focus-tab-8 "<Control>8"
        focus-tab-9 "<Control>9"
        focus-tab-10 "<Control>0"
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

for_each "gsettings set org.gnome.desktop.wm.keybindings " << 'BASH'
    # TODO rethink workspace switching keybindings
    # TODO add home row keybindings for workspaces 9 and 10
    always-on-top "['<Control><Super>space']"
    move-to-workspace-1 "['<Control><Alt><Super>h', '<Alt><Shift>1', '<Control><Alt><Super>Home']"
    move-to-workspace-2 "['<Control><Alt><Super>j', '<Alt><Shift>2']"
    move-to-workspace-3 "['<Control><Alt><Super>k', '<Alt><Shift>3']"
    move-to-workspace-4 "['<Control><Alt><Super>l', '<Alt><Shift>4']"
    move-to-workspace-5 "['<Control><Alt><Super>semicolon', '<Control><Alt><Super>ocircumflex', '<Alt><Shift>5']"
    move-to-workspace-6 "['<Control><Alt><Super>apostrophe', '<Control><Alt><Super>section', '<Alt><Shift>6']"
    move-to-workspace-7 "['<Control><Alt><Super>Return', '<Alt><Shift>7']"
    move-to-workspace-8 "['<Control><Alt><Super>backslash', '<Control><Alt><Super>ncaron', '<Alt><Shift>8']"
    move-to-workspace-9 "['<Alt><Shift>9']"
    move-to-workspace-10 "['<Alt><Shift>0']"
    move-to-workspace-last "['<Control><Alt><Super>End']"
    move-to-workspace-left "['<Control><Alt><Super>Left']"
    move-to-workspace-right "['<Control><Alt><Super>Right']"
    switch-to-workspace-1 "['<Control><Super>h', '<Alt>1', '<Control><Super>Home']"
    switch-to-workspace-2 "['<Control><Super>j', '<Alt>2']"
    switch-to-workspace-3 "['<Control><Super>k', '<Alt>3']"
    switch-to-workspace-4 "['<Control><Super>l', '<Alt>4']"
    switch-to-workspace-5 "['<Control><Super>semicolon', '<Control><Super>ocircumflex', '<Alt>5']"
    switch-to-workspace-6 "['<Control><Super>apostrophe', '<Control><Super>section', '<Alt>6']"
    switch-to-workspace-7 "['<Control><Super>Return', '<Alt>7']"
    switch-to-workspace-8 "['<Control><Super>backslash', '<Control><Super>ncaron', '<Alt>8']"
    switch-to-workspace-9 "['<Alt>9']"
    switch-to-workspace-10 "['<Alt>0']"
    switch-to-workspace-last "['<Control><Super>End']"
    switch-to-workspace-left "['<Control><Super>Left']"
    switch-to-workspace-right "['<Control><Super>Right']"
    toggle-fullscreen "['F11']"
BASH

for_each "gsettings set org.gnome.desktop.wm.preferences " << 'BASH'
    action-double-click-titlebar "toggle-maximize"
    action-middle-click-titlebar "lower" # 'minimize'
    auto-raise "true"
    button-layout "appmenu:minimize,close"
    focus-mode "sloppy"
    mouse-button-modifier "<Super>"
    num-workspaces "11"
    # NOTE: right click resizing is dependent on the sector of the window being
    # clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png
    resize-with-right-button "true"
    workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11']"
BASH

for_each "gsettings set org.gnome.shell.keybindings " << 'BASH'
    screenshot "['Print']"
    show-screenshot-ui "['<Shift><Super>s']"
    toggle-overview "['<Control><Alt><Super>o']"
    toggle-message-tray "[]"
BASH
