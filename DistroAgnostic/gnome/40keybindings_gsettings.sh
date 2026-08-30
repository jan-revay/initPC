#!/bin/bash
. ../../prelude.sh

# TODO move remaining keybindings from gsettings scripts here
# TODO TOREAD https://nikitabobko.github.io/AeroSpace/guide

for_each "gsettings set org.gnome.mutter.keybindings " << 'BASH'
    toggle-tiled-left "[]"
    toggle-tiled-right "[]"
BASH

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
    # TODO try finding a solution to also focus the window that has highest Z
    # order after the lower action.
    # TODO this does not seem to work (lower)
    lower "['<Control><Alt>space']"
    move-to-workspace-1 "['<Alt><Shift>Above_Tab', '<Control><Shift><Super>Home']"
    move-to-workspace-2 "['<Alt><Shift>1']"
    move-to-workspace-3 "['<Alt><Shift>2']"
    move-to-workspace-4 "['<Alt><Shift>3']"
    move-to-workspace-5 "['<Alt><Shift>4']"
    move-to-workspace-6 "['<Alt><Shift>5']"
    move-to-workspace-7 "['<Alt><Shift>6']"
    move-to-workspace-8 "['<Alt><Shift>7']"
    move-to-workspace-9 "['<Alt><Shift>8']"
    move-to-workspace-10 "['<Alt><Shift>9']"
    move-to-workspace-11 "['<Alt><Shift>0']"
    move-to-workspace-12 "['<Alt><Shift>minus']"
    move-to-workspace-last "['<Control><Shift><Super>End']"
    move-to-workspace-left "['<Control><Shift><Super>Left']"
    move-to-workspace-right "['<Control><Shift><Super>Right']"
    move-to-workspace-up "[]"
    move-to-workspace-down "[]"
    switch-group "[]"
    switch-group-backward "[]"
    switch-to-workspace-1 "['<Alt>Above_Tab', '<Control><Super>Home']"
    switch-to-workspace-2 "['<Alt>1']"
    switch-to-workspace-3 "['<Alt>2']"
    switch-to-workspace-4 "['<Alt>3']"
    switch-to-workspace-5 "['<Alt>4']"
    switch-to-workspace-6 "['<Alt>5']"
    switch-to-workspace-7 "['<Alt>6']"
    switch-to-workspace-8 "['<Alt>7']"
    switch-to-workspace-9 "['<Alt>8']"
    switch-to-workspace-10 "['<Alt>9']"
    switch-to-workspace-11 "['<Alt>0']"
    switch-to-workspace-12 "['<Alt>minus']"
    switch-to-workspace-last "['<Control><Super>End']"
    switch-to-workspace-left "['<Control><Super>Left']"
    switch-to-workspace-right "['<Control><Super>Right']"
    switch-to-workspace-up "[]"
    switch-to-workspace-down "[]"
    switch-windows "[]"
    switch-windows-backward "[]"
    cycle-windows "['<Alt>Tab']"
    cycle-windows-backward "['<Shift><Alt>Tab']"
    toggle-fullscreen "['F11']"
BASH

for_each "gsettings set org.gnome.settings-daemon.plugins.media-keys " << 'BASH'
# TODO fix mic mute - not working resp. not displaying notification correctly
    mic-mute "['<Shift><Super>a']"
    control-center "['<Super>s']"
BASH

for_each "gsettings set org.gnome.shell.keybindings " << 'BASH'
# NOTE: "quick-settings" is not Settings window but just the pop-up window
# in the upper right corner of the top-bar (where shut-down menu is).
# The correct key for gnome settings is in:
# org.gnome.settings-daemon.plugins.media-keys control-center
    toggle-quick-settings "[]"
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

# TODO move this function to the appropriate location
# TODO normalize error logging in the whole repo
# TODO set +x after the function is tested enough
gnome_add_custom_keybinding()
{
    set +x
    if [ "$#" -ne 3 ]; then
        echo "Invalid number of parameters" >&2
        echo "Usage: gnome_add_custom_keybinding <name> <binding> <command>" >&2
        echo "  <name> All name characters must match [a-z0-9_-]" >&2
        echo "         (e.g., 'my-terminal')." >&2
        echo "  <binding> is the keybinding (e.g., '<Super>Return')." >&2
        echo "  <command> is the shell command to run." >&2
        return 1
    fi

    if [[ -z "$1" ]]; then
        echo "Error: name must not be empty." >&2
        return 2
    fi

    if [[ "$1" =~ [^a-z0-9_-] ]]; then
        echo "Error: All characters in name parameter must match [a-z0-9_-]" >&2
        echo "         (e.g., 'my-terminal')." >&2
        return 3
    fi

    local -r name="state0_$1"
    local -r binding="$2"
    local -r command="$3"

    local -r schema="org.gnome.settings-daemon.plugins.media-keys"
    local reloc_schema base_path
    reloc_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
    base_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
    readonly reloc_schema base_path
    local -r path="${base_path}/${name}/"

    # Add path to custom-keybindings array if not present
    local -r current="$(gsettings get "${schema}" custom-keybindings)"
    if printf '%s\n' "${current}" | grep -q "'${path}'"; then
        echo "Keybinding ${name} is already present."
    else
        if [ "${current}" = "@as []" ]; then # the dconf array is empty
            local -r updated="['${path}']"
        else
            local -r updated_base=$(printf '%s' "${current}" | sed 's/]$//')
            local -r updated="${updated_base}, '${path}']"
        fi
        gsettings set "${schema}" custom-keybindings "${updated}"
        echo "The custom-keybindings array updated to: ${updated}"
    fi

    # Set the fields on the relocatable schema
    gsettings set "${reloc_schema}:${path}" name "${name}"
    gsettings set "${reloc_schema}:${path}" binding "${binding}"
    gsettings set "${reloc_schema}:${path}" command "${command}"

    echo "${reloc_schema}:${path} set to" \
        "name: '${name}', binding: '${binding}', command: '${command}'."
    set -x
}

# TODO - rewrite for_each to be able to run this without exporting:
export -f gnome_add_custom_keybinding

# TODO fix switching to ws 12 and 13 with SK keyboard layout
# TODO consider putting the keybinding last
for_each "gnome_add_custom_keybinding " << 'BASH'
    # name          keybinding                command
    kitty           "<Super>Above_Tab"        "kitty"
    firefox         "<Super>1"                "firefox --new-window"
    google-chrome   "<Super>2"                "google-chrome"
    qpwgraph        "<Super>3"                "qpwgraph"
    zen             "<Super>4"                "flatpak run app.zen_browser.zen"
    # using media-key home keybinding would just focus the existing Nautilus window
    nautilus    "<Super>e"                "nautilus --new-window"
    todoist     "<Shift><Super>q"         "todoist"
    switch-to-workspace-13 "<Alt>equal"          "wmctrl -s 12" # indexes begin at 0
    move-to-workspace-13 "<Alt><Shift>equal"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 12"
    switch-to-workspace-14 "<Alt>h"          "wmctrl -s 13" # indexes begin at 0
    move-to-workspace-14 "<Alt><Shift>h"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 13"
    switch-to-workspace-15 "<Alt>j"          "wmctrl -s 14" # indexes begin at 1
    move-to-workspace-15 "<Alt><Shift>j"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 14"
    switch-to-workspace-16 "<Alt>k"          "wmctrl -s 15" # indexes begin at 0
    move-to-workspace-16 "<Alt><Shift>k"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 15"
    switch-to-workspace-17 "<Alt>l"          "wmctrl -s 16" # indexes begin at 0
    move-to-workspace-17 "<Alt><Shift>l"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 16"
    # TODO - weird bug where setting Alt+; manually through GNOME settings
    # reports that it is already taken by switch-to-workspace-1 keybinding
    # (even though it is not).
    switch-to-workspace-18-en "<Alt>semicolon"     "wmctrl -s 17" # indexes begin at 0
    switch-to-workspace-18-sk "<Alt>ocircumflex"   "wmctrl -s 17" # indexes begin at 0
    move-to-workspace-18-en "<Shift><Alt>semicolon"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 17"
    move-to-workspace-18-sk "<Shift><Alt>ocircumflex"     "/home/jr/.my_scripts/move_focused_to_workspace.sh 17"
    obs-share-entire-screen "<Shift><Super>e"  "obs-cmd scene switch 'ENTIRE_SCREEN'"
    obs-share-vdo-ninja     "<Shift><Super>d"  "obs-cmd scene switch 'Camera - vdo.ninja'"
BASH
