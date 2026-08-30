#!/bin/bash
. ../../prelude.sh

readonly SCHDIR="${HOME}/.local/share/gnome-shell/extensions/compiled_schemas"
mkdir -p "${SCHDIR}"
find ~/.local/share/gnome-shell/extensions/ -name "*.gschema.xml" -exec cp -fu {} "${SCHDIR}" \;
glib-compile-schemas "${SCHDIR}"
# See: https://docs.gtk.org/gio/overview.html#running-gio-applications
export GSETTINGS_SCHEMA_DIR="${SCHDIR}"

# NOTE:
# 1. All for_each blocks are sorted by their respective gsettings path
# 2. All keys in a specific for_each block are sorted alphabetically

current_auto_move_windows=$(
    gsettings get org.gnome.shell.extensions.auto-move-windows application-list
)
readonly current_auto_move_windows

# auto-move-windows@gnome-shell-extensions.gcampax.github.com
# TODO Auto Move Windows - write a function that will add a string value to
# an array, but only if the string value is not already present. I.e. sth.
# similar to what I already use to set custom keybindings. Maybe just also
# reuse the code there.
# TODO consider just removing everything that was in the array before and always
# replacing here... it would be a simpler code and it would enforce 1:1 with
# configuration. Maybe the replace always policy is a good policy.
# TODO update 1:1 and then remove the if
# TODO finish the list + split it to two parts A) genersc B) machine specific
# TODO find a way to manage these dconf lists ad native lists so that the code
# is more intuitive and less error prone.
if [ "${current_auto_move_windows}" = "@as []" ]; then # the dconf array is empty
    gsettings set org.gnome.shell.extensions.auto-move-windows application-list \
        "['org.gnome.Settings.desktop:7', \
          'systemsettings.desktop:7', \
          'org.gnome.Shell.Extensions.desktop:7', \
          'com.mattjakeman.ExtensionManager.desktop:7', \
          'org.gnome.tweaks.desktop:7', \
          'snap-store_snap-store.desktop:7', \
          'org.signal.Signal.desktop:4', \
          'com.spotify.Client.desktop:12', \
          'gnome-system-monitor-kde.desktop:7']"
fi

# clipboard-history@alexsaveau.dev
for_each "gsettings set org.gnome.shell.extensions.clipboard-history " << 'BASH'
    cache-size "1000"
    display-mode "1"
    history-size "10000"
    next-entry "['<Alt>v']"
    prev-entry "['<Shift><Alt>v']"
    toggle-menu "['<Super>v']"
    toggle-private-mode "[]"
    topbar-preview-size "30"
    window-width-percentage "100"
BASH

# TODO go through the dock settings again and in detail
# ubuntu-dock@ubuntu.com
for_each "gsettings set org.gnome.shell.extensions.dash-to-dock " << 'BASH'
    always-center-icons "true"
    animation-time "0.01"
    click-action "previews"
    dash-max-icon-size "64"
    default-windows-preview-to-open "true"
    dock-fixed "false"
    dock-position "LEFT"
    extend-height "false"
    hot-keys "false"
    isolate-workspaces "true"
    isolate-monitors "true"
    middle-click-action "launch"
    pressure-threshold "50.0"
    preview-size-scale "0.25"
    scroll-action "cycle-windows"
    shift-click-action "minimize"
    shift-middle-click-action "quit"
    shortcut-timeout "4"
    show-mounts "false"
    show-show-apps-button "false"
    show-trash "false"
    show-windows-preview "true"
BASH

# TODO consider remowing the alternative shortcuts
# focus-changer@heartmire
for_each "gsettings set org.gnome.shell.extensions.focus-changer " << 'BASH'
    focus-down "['<Control><Alt>Down', '<Control><Alt>a']"
    focus-left "['<Control><Alt>Left', '<Control><Alt>z']"
    focus-right "['<Control><Alt>Right', '<Control><Alt>x']"
    focus-up "['<Control><Alt>Up', '<Control><Alt>s']"
BASH

# panelScroll@sun.wxg@gmail.com
for_each "gsettings set org.gnome.shell.extensions.panelScroll " << 'BASH'
    debounce "0"
    left "workspace"
    right "workspace"
    wrap "false"
BASH

# TODO consider using https://sw.kovidgoyal.net/kitty/kittens/quick-access-terminal/
# quake-terminal@diegodario88.github.io
for_each "gsettings set org.gnome.shell.extensions.quake-terminal " << 'BASH'
    always-on-top "true"
    animation-time "0"
    auto-hide-window "false"
    horizontal-alignment "1"
    horizontal-size "40"
    render-on-current-monitor "false"
    render-on-leftmost-monitor "false"
    render-on-primary-monitor "true"
    # terminal-id 'org.gnome.Ptyxis.desktop' - set terminal manually?
    terminal-id "kitty.desktop"
    vertical-size "50"
BASH

# TODO add all options
# system-monitor-next@paradoxxx.zero.gmail.com
for_each "gsettings set org.gnome.shell.extensions.system-monitor-next-applet " << 'BASH'
    cpu-graph-width "60"
    cpu-system-color "#c01c28ff"
    disk-display "true"
    disk-graph-width "60"
    icon-display "false"
    memory-graph-width "60"
    net-graph-width "60"
    rotate-labels "true"
    show-tooltip "true"
BASH

# TODO consider smaller window-hint-border-size e.g. 4 or 5
# Ubuntu 24.04
if gsettings get org.gnome.shell.extensions.tiling-assistant focus-hint; then
    for_each "gsettings set org.gnome.shell.extensions.tiling-assistant " << 'BASH'
        focus-hint "3"
        focus-hint-color "rgb(192,97,203)"
        focus-hint-outline-border-radius "6"
        focus-hint-outline-size "6"
        focus-hint-outline-style "1"
BASH
elif gsettings get org.gnome.shell.extensions.tiling-assistant active-window-hint; then
    for_each "gsettings set org.gnome.shell.extensions.tiling-assistant " << 'BASH'
        active-window-hint "2"
        active-window-hint-border-size "6"
        active-window-hint-color "rgb(192,97,203)"
BASH
fi # Ubuntu 26.04

# TODO also add numeric keyboard tiling shortcuts just in case
# TODO find out what is the difference between regular and -ignore-ta keybindings
# TODO go through tiling assistant issues and all settings again to find hidden gems :D
# TODO - check why predefined layouts do not tile completely in tiling assistant BUG
# tiling-assistant@ubuntu.com
for_each "gsettings set org.gnome.shell.extensions.tiling-assistant " << 'BASH'
    activate-layout0 "['<Shift><Alt>q']"
    activate-layout1 "['<Shift><Alt>w']"
    activate-layout2 "['<Shift><Alt>a']"
    activate-layout3 "['<Shift><Alt>s']"
    activate-layout4 "['<Shift><Control><Alt>q']" # center tile
    activate-layout5 "['<Shift><Control><Alt>e']" # file explorers
    activate-layout6 "['<Shift><Control><Alt>a']" # kitties
    activate-layout7 "['<Shift><Control><Alt>m']" # messaging
    activate-layout8 "['<Shift><Control><Alt>w']" # firefoxes - 3 columns
    dynamic-keybinding-behavior "0"
    enable-advanced-experimental-features "true"
    enable-raise-tile-group "false"
    enable-tile-animations "false"
    enable-tiling-popup "false"
    enable-untile-animations "false"
    maximize-with-gap "false"
    move-adaptive-tiling-mod "2"
    move-favorite-layout-mod "0"
    restore-window "['<Super>Down']"
    screen-top-gap "10"
    screen-left-gap "10"
    screen-right-gap "10"
    screen-bottom-gap "10"
    tile-bottom-half "['<Alt><Shift>x']"
    tile-bottomleft-quarter "['<Alt>a']"
    tile-bottomright-quarter "['<Alt>s']"
    tile-edit-mode "['<Shift><Control><Alt><Super>e']"
    tile-left-half "['<Alt>z']"
    tile-left-half-ignore-ta "['<Super>Left']"
    tile-maximize "['<Super>Up']"
    tile-right-half "['<Alt>x']"
    tile-right-half-ignore-ta "['<Super>Right']"
    tile-top-half "['<Alt><Shift>z']"
    tile-topleft-quarter "['<Alt>q']"
    tile-topright-quarter "['<Alt>w']"
    tiling-popup-all-workspace "false"
    window-gap "8"
BASH

# TODO configure Tiling shell in detail & in congruence with other keybindings
# and settings. https://github.com/domferr/tilingshell
# TODO go through the settings, help and manuals in detail
# tilingshell@ferrarodomenico.com
for_each "gsettings set org.gnome.shell.extensions.tilingshell " << 'BASH'
    active-screen-edges "false"
    cycle-layouts "['<Control><Alt><Super>l']"
    cycle-layouts-backward "['<Shift><Control><Alt><Super>l']"
    enable-move-keybindings "true"
    enable-span-multiple-tiles "false"
    focus-window-down "['<Control><Alt>j']"
    focus-window-left "['<Control><Alt>h']"
    focus-window-right "['<Control><Alt>l']"
    focus-window-up "['<Control><Alt>k']"
    inner-gaps "8"
    move-window-down "['<Shift><Control><Alt><Super>Down']"
    move-window-left "['<Shift><Control><Alt><Super>Left']"
    move-window-right "['<Shift><Control><Alt><Super>Right']"
    move-window-up "['<Shift><Control><Alt><Super>Up']"
    outer-gaps "10"
    # TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
    # test whether setting these two values in tiling shell is consistent and behaves
    # the same as setting them in the Extension settings app (if not correct that)
    # I probably need to do more
    overridden-settings '{"org.gnome.mutter.keybindings":{"toggle-tiled-right":"@as []","toggle-tiled-left":"@as []"},"org.gnome.desktop.wm.keybindings":{"maximize":"@as []","unmaximize":"@as []"}}'
    restore-window-original-size "false"
    snap-assist-sync-layout "true"
    span-multiple-tiles-activation-key "['-1']"
    tiling-system-deactivation-key "['1']"
BASH

# TODO configure in detail
# Vitals@CoreCoding.com
for_each "gsettings set org.gnome.shell.extensions.vitals " << 'BASH'
    fixed-widths "false"
BASH

# window-title-is-back@fthx
for_each "gsettings set org.gnome.shell.extensions.window-title-is-back " << 'BASH'
    colored-icon "true"
    ease-time "10"
    fixed-width "true"
    icon-size "25"
    show-app "true"
    show-icon "true"
    show-title "true"
    width "10"
BASH

# TODO add Size and spacing settings - go through setting up from defaults again (reinstall)
# TODO configure in detail
# workspaces-by-open-apps@favo02.github.com
for_each "gsettings set org.gnome.shell.extensions.workspaces-indicator-by-open-apps " << 'BASH'
    apps-inactive-effect "NOTHING"
    apps-minimized-effect "NOTHING"
    click-on-active-overview "false"
    icons-group "GROUP AND SHOW COUNT"
    indicator-hide-empty "false"
    indicator-round-borders "false"
    indicator-show-background "true"
    indicator-use-custom-names "true"
    scroll-enable "false"
    windows-sort-method "COORDINATES"
BASH
