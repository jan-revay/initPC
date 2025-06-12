#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# Workflow: use `dconf watch /`, make the change via GUI,
# use `gsettings get` to check the path, use `gsettings set` to verify the setting
# add the line here...

# TODO sync with PopOS configs_install.sh
# TODO move this to CommonInitScripts folder (this is not OS specific but just
# GNOME specific)
# TODO add command to set GNOME terminal tab close keybinding to Ctrl+W
# TODO consider using dconf dump & dconf load instead of calling gsettings for every key
# see: https://askubuntu.com/questions/984205/how-to-save-gnome-settings-in-a-file

# TODO pohrat sa s tymi nastaveniami, ci vlastne su vsetky potrebne a robia to co chcem

. ../prelude.sh

. ../UbuntuCLI/configs_install.sh

# GNOME TWEAKS

# TODO add keyboard settings
# TODO add fonts settings scaling factor
# TODO add grup timeout setup to 1
# TODO add setup of Ubuntu tiling assistant GNOME extension (gaps, highlight
# the active window...).

# TOREAD:
# - https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/desktop_migration_and_administration_guide/configuration-overview-gsettings-dconf

# GSettings
# TODO describe the procedure of capturing the GSettings (Dconf monitor)
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red'
# this was set to true for some reason on my fresh Ubuntu 24.04 install
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.mutter dynamic-workspaces false

# TODO add descriptions to these settings in comments (via ChatGPT)

if bash -c '. ../prelude.sh; distro_version_ge 23' &> /dev/null; then
    gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true
    gsettings set org.gnome.shell.extensions.dash-to-dock default-windows-preview-to-open true
fi
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time '0.01'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'previews'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 64
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold '50.0'
gsettings set org.gnome.shell.extensions.dash-to-dock preview-size-scale '0.25'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock shift-middle-click-action 'launch'
gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-timeout '4'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-windows-preview true

gsettings set org.gnome.desktop.interface text-scaling-factor '1.2'
gsettings set org.gnome.desktop.interface cursor-size '64'
# gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'
# gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'
# gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'

gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower' # 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close'
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 8
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9']"
# NOTE: right click resizing is dependent on the sector of the window being
# clicked on, see: https://raw.githubusercontent.com/RamonUnch/AltSnap/main/HelpImages/TestWindow.png

# TODO design and add all keybindings
# TODO remove useless wm keybindings
# TODO make the keybindings work similar to AltSnap on windows (emulate AltSnap)
# TODO have a look what keybindings do other developers use for
# switching desktops and window navigation/tiling

# KEYBOARD SHORTCUTS (keybindings)
# note: the keyboard shortcuts are designed to behave the same regardless of the
# keyboard layout (EN or SK).
# TODO add a custom keybinding for gnome-system-monitor (ctrl+shift+esc)
# https://community.linuxmint.com/tutorial/view/1171
# and make sure that the process is idempotent
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
gsettings set org.gnome.desktop.wm.keybindings always-on-top "['<Control><Super>space']"
gsettings set org.gnome.desktop.interface enable-animations false

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Control><Super>h', '<Alt>1']"
# TODO FIX: ctrl+super+j switches to workspace 6 for some reason...
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Control><Super>j', '<Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Control><Super>k', '<Alt>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Control><Super>l', '<Alt>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 \
    "['<Control><Super>semicolon', '<Control><Super>ocircumflex', '<Alt>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 \
    "['<Control><Super>apostrophe', '<Control><Super>section', '<Alt>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 \
    "['<Control><Super>Return', '<Alt>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 \
    "['<Control><Super>backslash', '<Control><Super>ncaron', '<Alt>8']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Control><Super>End']"

# TODO - consider also adding Alt+1..5 resp. also Alt+QWERTY for workspace switching
# The advantage is that I can switch the workspace with one hand that way.
# TODO - inspect conflicting keybindings on Win and Linux first though

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Control><Alt><Super>h']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Control><Alt><Super>j']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Control><Alt><Super>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Control><Alt><Super>l']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 \
    "['<Control><Alt><Super>semicolon', '<Control><Alt><Super>ocircumflex']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 \
    "['<Control><Alt><Super>apostrophe', '<Control><Alt><Super>section']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 \
    "['<Control><Alt><Super>Return']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 \
    "['<Control><Alt><Super>backslash', '<Control><Alt><Super>ncaron']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Alt><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Alt><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "['<Control><Alt><Super>End']"

gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['F11']"
gsettings set org.gnome.desktop.wm.preferences auto-raise 'true'
gsettings set org.gnome.shell.keybindings screenshot "['Print']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"
gsettings set org.gnome.shell.keybindings toggle-overview "['<Control><Alt><Super>o']"
# gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Alt>s']"
# NOTE: <Alt>s is in confict with MS whiteboard shortcuts

# TODO - maybe add this where extensions are installed
# TODO add line breaks
# TODO consider direct dconf backup/restore instead
# https://ostechnix.com/backup-and-restore-linux-desktop-system-settings-with-dconf/
readonly SCHDIR="${HOME}/.local/share/gnome-shell/extensions/"

gsettings --schemadir \
    "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history toggle-menu "['<Super>v']"

gsettings --schemadir "${SCHDIR}/focus-changer@heartmire/schemas" \
    set org.gnome.shell.extensions.focus-changer focus-up "['<Shift><Control><Alt><Super>Up']"
gsettings --schemadir "${SCHDIR}/focus-changer@heartmire/schemas" \
    set org.gnome.shell.extensions.focus-changer focus-down "['<Shift><Control><Alt><Super>Down']"
gsettings --schemadir "${SCHDIR}/focus-changer@heartmire/schemas" \
    set org.gnome.shell.extensions.focus-changer focus-left "['<Shift><Control><Alt><Super>Left']"
gsettings --schemadir "${SCHDIR}/focus-changer@heartmire/schemas" \
    set org.gnome.shell.extensions.focus-changer focus-right "['<Shift><Control><Alt><Super>Right']"

# panelScroll@sun.wxg@gmail.com

gsettings --schemadir "${SCHDIR}/panelScroll@sun.wxg@gmail.com/schemas" \
    set org.gnome.shell.extensions.panelScroll left "workspace"
gsettings --schemadir "${SCHDIR}/panelScroll@sun.wxg@gmail.com/schemas" \
    set org.gnome.shell.extensions.panelScroll right "workspace"
gsettings --schemadir "${SCHDIR}/panelScroll@sun.wxg@gmail.com/schemas" \
    set org.gnome.shell.extensions.panelScroll wrap "false"
gsettings --schemadir "${SCHDIR}/panelScroll@sun.wxg@gmail.com/schemas" \
    set org.gnome.shell.extensions.panelScroll debounce "0"

# quake-terminal@diegodario88.github.io

gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal animation-time "0"
gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal auto-hide-window "false"
gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal horizontal-alignment "1"
gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal horizontal-size "40"
gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal vertical-size "50"
gsettings --schemadir "${SCHDIR}/quake-terminal@diegodario88.github.io/schemas" \
    set org.gnome.shell.extensions.quake-terminal always-on-top "true"

# clipboard-history@alexsaveau.dev
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history window-width-percentage "100"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history history-size "10000"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history cache-size "1000"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history display-mode "1"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history topbar-preview-size "45"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history toggle-private-mode "[]"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history next-entry "['<Alt>v']"
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history prev-entry "['<Shift><Alt>v']"

# TODO
# /org/gnome/shell/extensions/workspaces-indicator-by-open-apps/scroll-enable
# /org/gnome/shell/extensions/workspaces-indicator-by-open-apps/scroll-wraparound
# /org/gnome/shell/extensions/auto-move-windows/application-list
# ['org.gnome.Nautilus.desktop:3', 'com.sindresorhus.Caprine.desktop:4', 'snap-store_snap-store.desktop:7', 'gparted.desktop:7', 'code.desktop:2', 'chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Profile_3.desktop:4', 'org.signal.Signal.desktop:4', 'chrome-hpfldicfbfomlpcikngkocigghgafkph-Profile_3.desktop:4', 'gnome-session-properties.desktop:7', 'nvidia-settings.desktop:7', 'update-manager.desktop:7', 'org.gnome.tweaks.desktop:7', 'gnome-system-panel.desktop:7', 'org.gnome.SystemMonitor.desktop:7', 'software-properties-gtk.desktop:7', 'gnome-printers-panel.desktop:7', 'org.gnome.baobab.desktop:7', 'chrome-bbdeiblfgdokhlblpgeaokenkfknecgl-Profile_3.desktop:4']
# /org/gnome/desktop/interface/enable-animations  false

# TODO - does not work for some reason...
# for profile in $(gsettings get org.gnome.Terminal.ProfilesList list | tr -d "[],'"); do
# profile_path="/org/gnome/Terminal/Legacy/Profiles:/:$profile/"
# gsettings set "org.gnome.Terminal.Legacy.Profile:$profile_path" scrollback-lines 500000
# done

# TODO - keybindings - tostudy
# What is the difference between "Switch applications", "Switch windows",
# "Switch windows directly", "Switch windows of an application", and
# "Switch windows of an app directly" keybindings? Learn how to use them...
# (see GNOME settings)

# set default apps
xdg-mime default code.desktop text/markdown
xdg-mime default code.desktop application/x-shellscript
sudo update-alternatives --set editor /usr/bin/nvim

# TODOs:
# Add - add slovak qwerty keyboard layout
# set workspaces to static and number to 6
# set to dark theme
# add logid.cfg (logitech mouse) options copy paste (and add the logid file
# to the dotfiles repo)
#
#
# TODO - finish keyboard setup
# https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#One-click_key_functions
# e.g. swap esc and caps lock
# https://www.reddit.com/r/vim/comments/k5twce/switching_esc_with_caps_lock/
#
# https://www.baeldung.com/linux/vim-switch-back-normal-mode-options
# https://www.reddit.com/r/vim/comments/shndya/how_do_you_escape_to_normal_mode/

pushd RootDotfiles/
sudo stow -vvv --target=/ disable_highres_scroll/

# TODO do not stow this in a VM
if stow -vvv --no --target=/ MX3_MASTER_LOGID_CONFIG/; then
    sudo stow -vvv --target=/ MX3_MASTER_LOGID_CONFIG/
else
    sudo mv /etc/logid.cfg /etc/logid.cfg-initPCBackup"$(date '+%Y%m%d_%H%M%S')"
    sudo stow -vvv --target=/ MX3_MASTER_LOGID_CONFIG/
fi
popd
