#!/bin/bash -x

. ../prelude.sh

readonly SCHDIR="${HOME}/.local/share/gnome-shell/extensions/compiled_schemas"
mkdir -p "${SCHDIR}"
find ~/.local/share/gnome-shell/extensions/ -name "*.gschema.xml" -exec cp -fu {} "${SCHDIR}" \;
glib-compile-schemas "${SCHDIR}"
# See: https://docs.gtk.org/gio/overview.html#running-gio-applications
export GSETTINGS_SCHEMA_DIR="${SCHDIR}"

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

# TODO add the remaining settings
gsettings set org.gnome.shell.extensions.vitals fixed-widths "false"

# tiling-assistant@ubuntu.com
for_each "gsettings set org.gnome.shell.extensions.tiling-assistant" << 'BASH'
    enable-advanced-experimental-features "true"
    window-gap "8"
    focus-hint "3"
    focus-hint-outline-style "1"
    focus-hint-color "rgb(192,97,203)"
    focus-hint-outline-size "6"
    focus-hint-outline-border-radius "6"
    enable-tiling-popup "false"
    tiling-popup-all-workspace "false"
    dynamic-keybinding-behavior "0"
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
    pressure-threshold "50.0"
    preview-size-scale "0.25"
    shift-click-action "minimize"
    shift-middle-click-action "launch"
    shortcut-timeout "4"
    show-mounts "false"
    show-show-apps-button "false"
    show-trash "false"
    show-windows-preview "true"
BASH

# workspaces-by-open-apps@favo02.github.com
for_each "gsettings set org.gnome.shell.extensions.workspaces-indicator-by-open-apps" << 'BASH'
    indicator-show-background "true"
    scroll-enable "false"
BASH

# system-monitor-next@paradoxxx.zero.gmail.com
for_each "gsettings set org.gnome.shell.extensions.system-monitor-next-applet" << 'BASH'
    show-tooltip "true"
    rotate-labels "true"
    cpu-system-color "#c01c28ff"
BASH

# tilingshell@ferrarodomenico.com
for_each "gsettings set org.gnome.shell.extensions.tilingshell" << 'BASH'
    enable-move-keybindings "false"

    # TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
    # test whether setting these two values in tiling shell is consistent and behaves
    # the same as setting them in the Extension settings app (if not correct that)
    # I probably need to do more
    overridden-settings '{"org.gnome.mutter":{"edge-tiling":"false"}}'
BASH

# window-title-is-back@fthx
gsettings set org.gnome.shell.extensions.window-title-is-back fixed-width "false"
