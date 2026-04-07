#!/bin/bash
. ../../prelude.sh

if gsettings get org.gnome.Ptyxis scrollbar-policy; then
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
fi # Ubuntu 24.04

for_each "gsettings set org.gnome.desktop.wm.keybindings " << 'BASH'
    # TODO rethink workspace switching keybindings
    # TODO add home row keybindings for workspaces 9 to 12
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
    move-to-workspace-11 "['<Alt><Shift>minus']"
    move-to-workspace-12 "['<Alt><Shift>equal']"
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
    switch-to-workspace-11 "['<Alt>minus']"
    switch-to-workspace-12 "['<Alt>equal']"
    switch-to-workspace-last "['<Control><Super>End']"
    switch-to-workspace-left "['<Control><Super>Left']"
    switch-to-workspace-right "['<Control><Super>Right']"
    toggle-fullscreen "['F11']"
BASH

for_each "gsettings set org.gnome.settings-daemon.plugins.media-keys " << 'BASH'
    mic-mute "['<Shift><Super>a']"
BASH

for_each "gsettings set org.gnome.shell.keybindings " << 'BASH'
    screenshot "['Print']"
    show-screenshot-ui "['<Shift><Super>s']"
    toggle-overview "['<Control><Alt><Super>o']"
    toggle-message-tray "['<Super>m']"
    switch-to-application-1 "[]"
    switch-to-application-2 "[]"
    switch-to-application-3 "[]"
    switch-to-application-4 "[]"
    switch-to-application-5 "[]"
    switch-to-application-6 "[]"
    switch-to-application-7 "[]"
    switch-to-application-8 "[]"
    switch-to-application-9 "[]"
    open-new-window-application-1 "[]"
    open-new-window-application-2 "[]"
    open-new-window-application-3 "[]"
    open-new-window-application-4 "[]"
    open-new-window-application-5 "[]"
    open-new-window-application-6 "[]"
    open-new-window-application-7 "[]"
    open-new-window-application-8 "[]"
    open-new-window-application-9 "[]"
BASH

# TODO - add custom keybinding
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
#   ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding
#   '<Super>1'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command
#   'kitty'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name
#   'kitty'
#
#   TODO add custom keybinding
#   nautilus --new-window
#   to "['<Super>e']"
#
#   using home media key keybinding just focuses the existing window
