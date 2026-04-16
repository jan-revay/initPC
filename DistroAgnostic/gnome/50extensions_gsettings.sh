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
    topbar-preview-size "40"
    window-width-percentage "100"
BASH

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

# focus-changer@heartmire
for_each "gsettings set org.gnome.shell.extensions.focus-changer " << 'BASH'
    focus-down "['<Shift><Control><Alt><Super>Down', '<Control><Alt>a']"
    focus-left "['<Shift><Control><Alt><Super>Left', '<Control><Alt>z']"
    focus-right "['<Shift><Control><Alt><Super>Right', '<Control><Alt>x']"
    focus-up "['<Shift><Control><Alt><Super>Up', '<Control><Alt>s']"
BASH

# panelScroll@sun.wxg@gmail.com
for_each "gsettings set org.gnome.shell.extensions.panelScroll " << 'BASH'
    debounce "0"
    left "workspace"
    right "workspace"
    wrap "false"
BASH

# quake-terminal@diegodario88.github.io
for_each "gsettings set org.gnome.shell.extensions.quake-terminal " << 'BASH'
    always-on-top "true"
    animation-time "0"
    auto-hide-window "false"
    horizontal-alignment "1"
    horizontal-size "40"
    terminal-id 'org.gnome.Ptyxis.desktop'
    vertical-size "50"
BASH

# system-monitor-next@paradoxxx.zero.gmail.com
for_each "gsettings set org.gnome.shell.extensions.system-monitor-next-applet " << 'BASH'
    cpu-system-color "#c01c28ff"
    rotate-labels "true"
    show-tooltip "true"
    icon-display "false"
    net-graph-width "60"
    memory-graph-width "60"
    cpu-graph-width "60"
    disk-display "true"
    disk-graph-width "60"
BASH

# Ubuntu 24.04 CI
if gsettings get org.gnome.shell.extensions.tiling-assistant focus-hint; then

    # TODO also add numeric keyboard tiling shortcuts just in case
    # tiling-assistant@ubuntu.com
    for_each "gsettings set org.gnome.shell.extensions.tiling-assistant " << 'BASH'
        activate-layout0 "['<Shift><Alt>q']"
        activate-layout1 "['<Shift><Alt>w']"
        activate-layout2 "['<Shift><Alt>a']"
        activate-layout3 "['<Shift><Alt>s']"
        dynamic-keybinding-behavior "0"
        enable-advanced-experimental-features "true"
        enable-raise-tile-group "false"
        enable-tile-animations "false"
        enable-tiling-popup "false"
        enable-untile-animations "false"
        focus-hint "3"
        focus-hint-color "rgb(192,97,203)"
        focus-hint-outline-border-radius "6"
        focus-hint-outline-size "6"
        focus-hint-outline-style "1"
        maximize-with-gap "true"
        restore-window "['<Super>Down']"
        screen-top-gap "6"
        screen-left-gap "6"
        screen-right-gap "6"
        screen-bottom-gap "6"
        tile-bottomleft-quarter "['<Alt>a']"
        tile-bottomright-quarter "['<Alt>s']"
        tile-left-half "['<Alt>z']"
        tile-left-half-ignore-ta "['<Super>Left']"
        tile-maximize "['<Super>Up']"
        tile-right-half "['<Alt>x']"
        tile-right-half-ignore-ta "['<Super>Right']"
        tile-topleft-quarter "['<Alt>q']"
        tile-topright-quarter "['<Alt>w']"
        tiling-popup-all-workspace "false"
        window-gap "8"
BASH

fi # Ubuntu 24.04 CI

# TODO configure Tiling shell in detail & in congruence with other keybindings
# and settings.
# tilingshell@ferrarodomenico.com
for_each "gsettings set org.gnome.shell.extensions.tilingshell " << 'BASH'
    enable-move-keybindings "false"

    # TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
    # test whether setting these two values in tiling shell is consistent and behaves
    # the same as setting them in the Extension settings app (if not correct that)
    # I probably need to do more
    overridden-settings '{"org.gnome.mutter":{"edge-tiling":"false"}}'
BASH

# Vitals@CoreCoding.com
for_each "gsettings set org.gnome.shell.extensions.vitals " << 'BASH'
    fixed-widths "false"
BASH

# window-title-is-back@fthx
for_each "gsettings set org.gnome.shell.extensions.window-title-is-back " << 'BASH'
    colored-icon "true"
    fixed-width "false"
BASH

# workspaces-by-open-apps@favo02.github.com
for_each "gsettings set org.gnome.shell.extensions.workspaces-indicator-by-open-apps " << 'BASH'
    apps-minimized-effect "REDUCE OPACITY"
    apps-inactive-effect "NOTHING"
    click-on-active-overview "false"
    indicator-round-borders "false"
    indicator-show-background "true"
    scroll-enable "false"
BASH
