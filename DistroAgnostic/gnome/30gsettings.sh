#!/bin/bash
. ../../prelude.sh

# TODO sort again once ifdefs are removed
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

gsettings set org.gnome.system.locale region "en_GB.UTF-8"

# disable-lock-screen was set to true for some reason on my fresh Ubuntu 24.04 install
if [[ $(gsettings get org.gnome.desktop.lockdown disable-lock-screen) != "false" ]]; then
    gsettings set org.gnome.desktop.lockdown disable-lock-screen "false"
fi

for_each "gsettings set org.gnome.desktop.peripherals.touchpad " << 'BASH'
    click-method "fingers"
    disable-while-typing "true"
    send-events "disabled-on-external-mouse"
BASH

# GNOME settings -> Search (influences results in super_L overview search menu)
gsettings set org.gnome.desktop.search-providers disabled \
    "['org.gnome.seahorse.Application.desktop', 'org.gnome.clocks.desktop', \
 'org.gnome.Calendar.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Terminal.desktop']"

for_each "gsettings set org.gnome.desktop.wm.preferences " << 'BASH'
    action-double-click-titlebar "toggle-maximize"
    action-middle-click-titlebar "lower" # 'minimize'
    auto-raise "true"
    button-layout "appmenu:minimize,close"
    focus-mode "sloppy"
    mouse-button-modifier "<Super>"
    num-workspaces "18"
    # NOTE: right click resizing is dependent on the sector of the window being
    # clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png
    resize-with-right-button "true"
    workspace-names "['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17']"
BASH

for_each "gsettings set org.gnome.mutter " << 'BASH'
    attach-modal-dialogs "false"
    center-new-windows "false"
    dynamic-workspaces "false"
    overlay-key "Super_L"
    workspaces-only-on-primary "true"
BASH

for_each "gsettings set org.gnome.settings-daemon.plugins.power " << 'BASH'
    ambient-enabled "false"
    idle-dim "false"
    lid-close-ac-action "nothing"
    lid-close-battery-action "nothing"
    sleep-inactive-ac-timeout "0"
    sleep-inactive-ac-type "nothing"
    sleep-inactive-battery-timeout "0"
    sleep-inactive-battery-type "nothing"
BASH

for_each "gsettings set org.gnome.settings-daemon.plugins.housekeeping " << 'BASH'
    free-percent-notify "0.09375"
    free-percent-notify-again "0.0625"
    free-size-gb-no-notify "20"
BASH

for_each "gsettings set org.gnome.shell.app-switcher " << 'BASH'
    current-workspace-only "true"
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
    enable-animations "false"
    color-scheme "prefer-dark"
    gtk-theme "Yaru-red-dark"
    icon-theme "Yaru-red-dark"
    show-battery-percentage "true"
BASH

# Ubuntu 24.04
if gsettings get org.gnome.desktop.interface accent-color; then
    for_each "gsettings set org.gnome.desktop.interface " << 'BASH'
        accent-color "red"
BASH

fi

# Ubuntu 26.04
if gsettings get org.gnome.Ptyxis restore-session; then
    for_each "gsettings set org.gnome.Ptyxis " << 'BASH'
        restore-session "false"
        restore-window-size "false"
        scrollbar-policy "always"
BASH
fi

# If on my work ThinkPad P1 Gen8
if lscpu | grep -F "Intel(R) Core(TM) Ultra 7 265H"; then
    for_each "gsettings set org.gnome.desktop.interface " << 'BASH'
        cursor-size "64"
        document-font-name "Sans 13"
        font-hinting "slight"
        font-name "Ubuntu Sans 14"
        monospace-font-name "Ubuntu Sans Mono 15"

        # WARNING: text-scaling-factor can break Chromium (or other GTK apps) and cause
        # the app window to increase in size on refocus (due to floating point rounding
        # errors). Always set the value to decimal that can be represented as float without
        # rounding error and also test whether the Chromium window does not change size on
        # refocus with the specific value.
        # TODO consider using 1 as scaling factor and setting interface/document/monospace fonts instead
        text-scaling-factor "1.25"
        # TODO also try fractional scaling on laptop monitor
        # TODO try          1.234375 , 1.21875 and 1.1875
        # equals in binary  1.001111 , 1.00111, 1.0011

BASH
fi
