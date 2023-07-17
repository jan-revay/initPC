#!/bin/bash

# TODO Wayland support
# TODO improve - try sth. that is not dependent on timing so much
# TODO remove dependence on the put window GNOME extension
# TODO try writing my own GNOME extension for this stuff
# TODO ?try to solve this via virtual desktop-specific tiling?

# sleep 120

# use `$ xprop` to find out the properties of the window (e.g. class)

eval "$(xdotool search --onlyvisible --desktop 3 --shell --class org.gnome.Nautilus)"
xdotool windowsize "${WINDOWS[1]}" 50% 40%
xdotool windowsize "${WINDOWS[0]}" 50% 40%

xdotool windowmove "${WINDOWS[0]}" 0% 60%
xdotool windowmove "${WINDOWS[1]}" 50% 60%

eval "$(xdotool search --onlyvisible --shell --name "Google Chrome")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 0
xdotool windowmove "${WINDOWS[0]}" 0% 16%
xdotool windowsize "${WINDOWS[0]}" 102% 86%

eval "$(xdotool search --onlyvisible --shell --name "Mozilla Firefox")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 2
xdotool windowmove "${WINDOWS[0]}" 0% 16%
xdotool windowsize "${WINDOWS[0]}" 102% 86%

eval "$(xdotool search --onlyvisible --shell --name "Todoist")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 1
xdotool windowmove "${WINDOWS[0]}" 0% 0%
xdotool windowsize "${WINDOWS[0]}" 80% 45%

eval "$(xdotool search --onlyvisible --shell --name "Google Keep")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 2

eval "$(xdotool search --onlyvisible --shell --name "Caprine")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 4

eval "$(xdotool search --onlyvisible --shell --name "Signal")"
xdotool set_desktop_for_window "${WINDOWS[0]}" 4
