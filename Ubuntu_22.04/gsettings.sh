#!/bin/bash -x

# HOW TO WATCH GSettings changes on Ubuntu? Run `dconf watch /`

# Appends a prefix in the first parameter to every line from stdin and executes
# the resulting command. Ignores comments and empty lines.
for_each()
{
    set +x
    local prefix="$1"
    local line
    while read -r line; do # Read a line and strip leading and trailing spaces
        # Skip empty lines and comments
        [[ "$line" =~ ^[[:space:]]*(#|$) ]] && continue
        bash -cx "$prefix $line"
    done
    set -x
}

readonly SCHDIR="${HOME}/.local/share/gnome-shell/extensions/compiled_schemas"
mkdir -p "${SCHDIR}"
find ~/.local/share/gnome-shell/extensions/ -name "*.gschema.xml" -exec cp -fu {} "${SCHDIR}" \;
glib-compile-schemas "${SCHDIR}"
export GSETTINGS_SCHEMA_DIR="${SCHDIR}"

# this was set to true for some reason on my fresh Ubuntu 24.04 install
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.mutter dynamic-workspaces false

for_each "gsettings set org.gnome.desktop.input-sources" << 'BASH'
    per-window true
    sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
    xkb-options "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"
BASH

for_each "gsettings set org.gnome.desktop.interface" << 'BASH'
    # WARNING: text-scaling-factor can break Chromium (or other GTK apps) and cause
    # the app window to increase in size on refocus (due to floating point rounding
    # errors). Always set the value to decimal that can be represented as float without
    # rounding error and also test whether the Chromium window does not change size on
    # refocus with the specific value.
    # TODO consider using 1 as scaling factor and setting interface/document/monospace fonts instead
    text-scaling-factor '1' 
    # text-scaling-factor '1.1875' # this should also work - 1.0011 in binary
    font-name 'Ubuntu Sans 13'
    document-font-name 'Sans 13'
    monospace-font-name 'Ubuntu Sans Mono 15'

    font-hinting 'slight'
    cursor-size '64'

    enable-animations 'false'

    accent-color 'red'
    color-scheme 'prefer-dark'
    gtk-theme 'Yaru-red-dark'
    icon-theme 'Yaru-red-dark'
BASH

for_each "gsettings set org.gnome.shell.extensions.dash-to-dock" << 'BASH'
    always-center-icons true
    animation-time '0.01'
    click-action 'previews'
    dash-max-icon-size 64
    default-windows-preview-to-open true
    dock-fixed false
    dock-position 'LEFT'
    extend-height 'false'
    hot-keys 'false'
    pressure-threshold '50.0'
    preview-size-scale '0.25'
    shift-click-action 'minimize'
    shift-middle-click-action 'launch'
    shortcut-timeout '4'
    show-mounts 'false'
    show-show-apps-button 'false'
    show-trash 'false'
    show-windows-preview 'true'
BASH

for_each "gsettings set org.gnome.desktop.wm.preferences" << 'BASH'
    action-double-click-titlebar 'toggle-maximize'
    action-middle-click-titlebar 'lower' # 'minimize'
    auto-raise 'true'
    button-layout 'appmenu:minimize,close'
    focus-mode 'sloppy'
    mouse-button-modifier '<Super>'
    num-workspaces 10
    # NOTE: right click resizing is dependent on the sector of the window being
    # clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png
    resize-with-right-button true
    workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']"
BASH

gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"

for_each "gsettings set org.gnome.desktop.wm.keybindings" << 'BASH'
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

for_each "gsettings set org.gnome.shell.keybindings" << 'BASH'
    screenshot "['Print']"
    show-screenshot-ui "['<Shift><Super>s']"
    toggle-overview "['<Control><Alt><Super>o']"
    toggle-message-tray "[]"
BASH

for_each "gsettings set org.gnome.Ptyxis" << 'BASH'
    restore-session 'false'
    restore-window-size 'false'
    scrollbar-policy 'always'
BASH

for_each "gsettings set org.gnome.Ptyxis.Shortcuts" << 'BASH'
    move-next-tab '<Control>Tab'
    move-previous-tab '<Shift><Control>Tab'
    focus-tab-1 '<Control>1'
    focus-tab-2 '<Control>2'
    focus-tab-3 '<Control>3'
    focus-tab-4 '<Control>4'
    focus-tab-5 '<Control>5'
    focus-tab-6 '<Control>6'
    focus-tab-7 '<Control>7'
    focus-tab-8 '<Control>8'
    focus-tab-9 '<Control>9'
    focus-tab-10 '<Control>0'
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

# workspaces-by-open-apps@favo02.github.com
for_each "gsettings set org.gnome.shell.extensions.workspaces-indicator-by-open-apps" << 'BASH'
    indicator-show-background "true"
    scroll-enable "false"
BASH

# system-monitor-next@paradoxxx.zero.gmail.com
for_each "gsettings set org.gnome.shell.extensions.system-monitor-next-applet" << 'BASH'
    show-tooltip 'true'
    rotate-labels 'true'
    cpu-system-color '#c01c28ff'
BASH

# tilingshell@ferrarodomenico.com
for_each "gsettings set org.gnome.shell.extensions.tilingshell" << 'BASH'
    enable-move-keybindings 'false'

    # TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
    # test whether setting these two values in tiling shell is consistent and behaves
    # the same as setting them in the Extension settings app (if not correct that)
    # I probably need to do more
    overridden-settings '{"org.gnome.mutter":{"edge-tiling":"false"}}'
BASH

# window-title-is-back@fthx
gsettings set org.gnome.shell.extensions.window-title-is-back fixed-width 'false'
