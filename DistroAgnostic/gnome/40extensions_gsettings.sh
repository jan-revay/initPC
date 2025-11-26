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

# clipboard-history@alexsaveau.dev
for_each "gsettings set org.gnome.shell.extensions.clipboard-history" << 'BASH'
    cache-size "1000"
    display-mode "1"
    history-size "10000"
    next-entry "['<Alt>v']"
    prev-entry "['<Shift><Alt>v']"
    toggle-menu "['<Super>v']"
    toggle-private-mode "[]"
    topbar-preview-size "45"
    window-width-percentage "100"
BASH

# ubuntu-dock@ubuntu.com
for_each "gsettings set org.gnome.shell.extensions.dash-to-dock" << 'BASH'
    always-center-icons "true"
    animation-time "0.01"
    click-action "previews"
    dash-max-icon-size "64"
    default-windows-preview-to-open "true"
    dock-fixed "false"
    dock-position "LEFT"
    extend-height "false"
    hot-keys "false"
    middle-click-action "launch"
    pressure-threshold "50.0"
    preview-size-scale "0.25"
    shift-click-action "minimize"
    shift-middle-click-action "quit"
    shortcut-timeout "4"
    show-mounts "false"
    show-show-apps-button "false"
    show-trash "false"
    show-windows-preview "true"
BASH

# focus-changer@heartmire
for_each "gsettings set org.gnome.shell.extensions.focus-changer" << 'BASH'
    focus-down "['<Shift><Control><Alt><Super>Down']"
    focus-left "['<Shift><Control><Alt><Super>Left']"
    focus-right "['<Shift><Control><Alt><Super>Right']"
    focus-up "['<Shift><Control><Alt><Super>Up']"
BASH

# panelScroll@sun.wxg@gmail.com
for_each "gsettings set org.gnome.shell.extensions.panelScroll" << 'BASH'
    debounce "0"
    left "workspace"
    right "workspace"
    wrap "false"
BASH

# quake-terminal@diegodario88.github.io
for_each "gsettings set org.gnome.shell.extensions.quake-terminal" << 'BASH'
    always-on-top "true"
    animation-time "0"
    auto-hide-window "false"
    horizontal-alignment "1"
    horizontal-size "40"
    vertical-size "50"
BASH

# system-monitor-next@paradoxxx.zero.gmail.com
for_each "gsettings set org.gnome.shell.extensions.system-monitor-next-applet" << 'BASH'
    cpu-system-color "#c01c28ff"
    rotate-labels "true"
    show-tooltip "true"
BASH

# Ubuntu 24.04 CI
if gsettings get org.gnome.shell.extensions.tiling-assistant focus-hint; then

    # tiling-assistant@ubuntu.com
    for_each "gsettings set org.gnome.shell.extensions.tiling-assistant" << 'BASH'
        dynamic-keybinding-behavior "0"
        enable-advanced-experimental-features "true"
        enable-tiling-popup "false"
        focus-hint "3"
        focus-hint-color "rgb(192,97,203)"
        focus-hint-outline-border-radius "6"
        focus-hint-outline-size "6"
        focus-hint-outline-style "1"
        tiling-popup-all-workspace "false"
        window-gap "8"
BASH

fi # Ubuntu 24.04 CI

# tilingshell@ferrarodomenico.com
for_each "gsettings set org.gnome.shell.extensions.tilingshell" << 'BASH'
    enable-move-keybindings "false"

    # TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
    # test whether setting these two values in tiling shell is consistent and behaves
    # the same as setting them in the Extension settings app (if not correct that)
    # I probably need to do more
    overridden-settings '{"org.gnome.mutter":{"edge-tiling":"false"}}'
BASH

# Vitals@CoreCoding.com
for_each "gsettings set org.gnome.shell.extensions.vitals" << 'BASH'
    fixed-widths "false"
BASH

# window-title-is-back@fthx
for_each "gsettings set org.gnome.shell.extensions.window-title-is-back" << 'BASH'
    fixed-width "false"
BASH

# workspaces-by-open-apps@favo02.github.com
for_each "gsettings set org.gnome.shell.extensions.workspaces-indicator-by-open-apps" << 'BASH'
    indicator-show-background "true"
    scroll-enable "false"
BASH
