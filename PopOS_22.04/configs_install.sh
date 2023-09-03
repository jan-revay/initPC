#!/bin/bash -x
# BASE IMAGE: PopOS 22.04
# WARNING: this script is not up todate and also does not work - has a lot of bugs
# it is more of an WIP record of TODOs and stubs than something usable
echo Read the warning in the script
exit 77

export PS4="\[\033[1;93m\]+ \[\033[0m\]"

# TODO
# in settings
#    - desktop icons large

. ../CommonInitScripts/git_config.sh.ps1

. ../CommonInitScripts/mkdirs.sh

# GNOME TWEAKS

# TODO add lower window on middle click
# TODO add keyboard settings
# TODO add fonts settings scaling factor

# GSettings
# TODO browse through dconf app and customize everything relevant
# TODO test all these settings (whether they work, set stuff in Dconf and whether
# they work as intended)
# TODO describe the procedure of capturing the GSettings (Dconf monitor)
# TODO normalize keyboard shortcuts for copy pasting and copy pasting from terminal
# ideally switch Ctrl+C and Shift+Ctrl+C in terminal settings
# TODO problem witch vim on Allacrity on Pop (try later release of Allacrity or reporting the bug)
# TODO try Kitty terminal from JG and some other terminal emulators from my notes
# KEYBOARD SHORTCUTS AND SETTINGS
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
# TODO test the keyboard settings
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
# TODO do some more research wrt to org.gnome.mutter.keybindings mainly rotate-monitor keybinding
# also /org/gnome/desktop/wm/keybindings/

gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'minimize'
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:close'
gsettings set org.gnome.desktop.interface locate-pointer 'true'
gsettings set org.gnome.desktop.interface cursor-size '48'
gsettings set org.gnome.desktop.interface enable-animations 'false'
gsettings set org.gnome.desktop.wm.preferences auto-raise 'true'
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences num-workspaces '7'
gsettings set org.gnome.mutter dynamic-workspaces 'false'
gsettings set org.gnome.mutter workspaces-only-on-primary 'true'

# GNOME EXTENSIONS
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '80'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide 'true'
gsettings set org.gnome.shell.extensions.pop-cosmic show-applications-button 'false'
gsettings set org.gnome.shell.extensions.pop-cosmic show-workspaces-button 'false'
gsettings set org.gnome.shell.extensions.pop-cosmic workspace-picker-left 'true'
# TODO split that long line to multiple lines (find an elegant way)
gsettings set org.gnome.shell.extensions.auto-move-windows application-list \
    "['google-chrome.desktop:1', 'firefox.desktop:3', 'org.signal.Signal.desktop:4', 'code.desktop:2', 'com.todoist.Todoist.desktop:3', 'org.gnome.Nautilus.desktop:4']"
gsettings set com.github.repsac-by.quake-mode quake-mode-tray 'false'
gsettings set com.github.repsac-by.quake-mode quake-mode-hide-from-overview 'true'
gsettings set com.github.repsac-by.quake-mode quake-mode-always-on-top 'true'
gsettings set com.github.repsac-by.quake-mode quake-mode-halign 'center'
gsettings set com.github.repsac-by.quake-mode quake-mode-valign 'top'
# TODO - add browser window in quake mode
# TODO - add exception for the terminal window in tiling WM
# TODO - create a separate app launcher for the alacritty in quake mode so that
# I can use it with tiling despite the cast that it has the exception
# I need to somehow add the .desktop file to /usr/share/applications/usr/share/applications
gsettings set com.github.repsac-by.quake-mode.accelerators quake-mode-accelerator-1 "['F12']"
gsettings set com.github.repsac-by.quake-mode.apps app-1 'com.alacritty.Alacritty.desktop'

gsettings set org.gnome.shell.extensions.net.gfxmonk.scroll-workspaces ignore-last-workspace 'true'
gsettings set org.gnome.shell.extensions.net.gfxmonk.scroll-workspaces wrap 'true'
gsettings set org.gnome.shell.extensions.net.gfxmonk.scroll-workspaces indicator 'false'

# TODO set vitals

if ! grep my_bashrc ~/.bashrc; then
    echo "
if [ -f ~/.my_bashrc ]; then
    . ~/.my_bashrc
fi" >> ~/.bashrc
fi

# set default apps
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop application/x-shellscript
sudo update-alternatives --set editor /usr/bin/nvim
