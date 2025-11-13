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
# TODO normalise '' and " usage and also usage without " or '
# TODO - conflict with Ubuntu settings multitasking tab and gsettings (dash-to-dock and tiling manager...)

# TOREAD:
# - https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/desktop_migration_and_administration_guide/configuration-overview-gsettings-dconf

sudo prime-select nvidia

for_each()
{
    if [[ -z "$1" ]]; then
        echo Error: Missing parameter
        echo 'Usage: for_each <command> <<EOF ... EOF'
        echo Appends a prefix from the first parameter to every line from stdin
        echo and runs the resulting commands. Ignores empty lines and lines
        echo "starting with a # character."
        return 1
    fi

    grep -vE '^[[:space:]]*(#|$)' | xargs -r -d '\n' -I{} "$1" "{}"
}

# GSettings
# TODO describe the procedure of capturing the GSettings (Dconf monitor)
gsettings set org.gnome.desktop.input-sources per-window true
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
gsettings set org.gnome.desktop.input-sources xkb-options \
    "['terminate:ctrl_alt_bksp', 'shift:both_capslock_cancel', 'caps:none']"

# this was set to true for some reason on my fresh Ubuntu 24.04 install
gsettings set org.gnome.desktop.lockdown disable-lock-screen false
gsettings set org.gnome.mutter dynamic-workspaces false

# TODO add descriptions to these settings in comments (via ChatGPT)

if bash -c '. ../prelude.sh; distro_version_ge 23' &> /dev/null; then
    gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true
    gsettings set org.gnome.shell.extensions.dash-to-dock default-windows-preview-to-open true
fi

for_each "gsettings set org.gnome.shell.extensions.dash-to-dock" << EOF
animation-time '0.01'
click-action 'previews'
dash-max-icon-size 64
dock-fixed false
dock-position 'LEFT'
extend-height 'false'
hot-keys 'false'
# TODO find out why changing this to true resp. false does nothing
isolate-workspaces 'true'
pressure-threshold '50.0'
preview-size-scale '0.25'
shift-click-action 'minimize'
shift-middle-click-action 'launch'
shortcut-timeout '4'
show-mounts 'false'
show-show-apps-button 'false'
show-trash 'false'
show-windows-preview 'true'
EOF

# WARNING: text-scaling-factor can break Chromium (or other GTK apps) and cause
# the app window to increase in size on refocus (due to floating point rounding
# errors). Always set the value to decimal that can be represented as float without
# rounding error and also test whether the Chromium window does not change size on
# refocus with the specific value.
# gsettings set org.gnome.desktop.interface text-scaling-factor '1.1875' # TODO consider using 1 as scaling factor and setting interface/document/monospace fonts instead
gsettings set org.gnome.desktop.interface text-scaling-factor '1' # TODO consider using 1 as scaling factor and setting interface/document/monospace fonts instead
gsettings set org.gnome.desktop.interface font-name 'Ubuntu Sans 13'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 13'
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Sans Mono 15'
gsettings set org.gnome.desktop.interface font-hinting 'slight'
gsettings set org.gnome.desktop.interface cursor-size '64'
gsettings set org.gnome.desktop.interface enable-animations 'false'
# TODO consider not setting the theme (it might mess stuff up)

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface accent-color 'red'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-red-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-red-dark'

# gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'
# gsettings set org.gnome.desktop.background picture-uri-dark 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'
# gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/Northan_lights_by_mizuno.webp'

gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower' # 'minimize'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,close'
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Super>'
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button true
gsettings set org.gnome.desktop.wm.preferences workspace-names "['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']"
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

# TODO pridat home row keybindings k workspace 9 a 10
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
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 \
    "['<Alt>9']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 \
    "['<Alt>0']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Super>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Super>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Control><Super>End']"

# TODO - consider also adding Alt+1..5 resp. also Alt+QWERTY for workspace switching
# The advantage is that I can switch the workspace with one hand that way.
# TODO - inspect conflicting keybindings on Win and Linux first though

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Control><Alt><Super>h', '<Alt><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Control><Alt><Super>j', '<Alt><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Control><Alt><Super>k', '<Alt><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Control><Alt><Super>l', '<Alt><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 \
    "['<Control><Alt><Super>semicolon', '<Control><Alt><Super>ocircumflex', '<Alt><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 \
    "['<Control><Alt><Super>apostrophe', '<Control><Alt><Super>section', '<Alt><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 \
    "['<Control><Alt><Super>Return', '<Alt><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 \
    "['<Control><Alt><Super>backslash', '<Control><Alt><Super>ncaron', '<Alt><Shift>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Alt><Shift>9']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Alt><Shift>0']"

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

gsettings set org.gnome.Ptyxis restore-session 'false'
gsettings set org.gnome.Ptyxis restore-window-size 'false'
gsettings set org.gnome.Ptyxis scrollbar-policy 'always'
gsettings set org.gnome.Ptyxis.Shortcuts move-next-tab '<Control>Tab'
gsettings set org.gnome.Ptyxis.Shortcuts move-previous-tab '<Shift><Control>Tab'

gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-1 '<Control>1'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-2 '<Control>2'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-3 '<Control>3'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-4 '<Control>4'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-5 '<Control>5'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-6 '<Control>6'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-7 '<Control>7'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-8 '<Control>8'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-9 '<Control>9'
gsettings set org.gnome.Ptyxis.Shortcuts focus-tab-10 '<Control>0'

# TODO - maybe add this where extensions are installed
# TODO add line breaks
# TODO consider direct dconf backup/restore instead
# https://ostechnix.com/backup-and-restore-linux-desktop-system-settings-with-dconf/
readonly SCHDIR="${HOME}/.local/share/gnome-shell/extensions"

# focus-changer@heartmire
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
gsettings --schemadir "${SCHDIR}/clipboard-history@alexsaveau.dev/schemas" \
    set org.gnome.shell.extensions.clipboard-history toggle-menu "['<Super>v']"

# Vitals
# TODO add the remaining settings
gsettings --schemadir "${SCHDIR}/Vitals@CoreCoding.com/schemas" \
    set org.gnome.shell.extensions.vitals fixed-widths "false"

# tiling-assistant@ubuntu.com
gsettings set org.gnome.shell.extensions.tiling-assistant enable-advanced-experimental-features "true"
gsettings set org.gnome.shell.extensions.tiling-assistant window-gap "8"
gsettings set org.gnome.shell.extensions.tiling-assistant focus-hint "3"
gsettings set org.gnome.shell.extensions.tiling-assistant focus-hint-outline-style "1"
gsettings set org.gnome.shell.extensions.tiling-assistant focus-hint-color "rgb(192,97,203)"
gsettings set org.gnome.shell.extensions.tiling-assistant focus-hint-outline-size "6"
gsettings set org.gnome.shell.extensions.tiling-assistant focus-hint-outline-border-radius "6"
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tiling-popup "false"
gsettings set org.gnome.shell.extensions.tiling-assistant tiling-popup-all-workspace "false"
gsettings set org.gnome.shell.extensions.tiling-assistant dynamic-keybinding-behavior "0"

# TODO - add a TODOist keybinding
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
#   ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding
#   '<Shift><Super>q'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command
#   'todoist'
# /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name
#   'Todoist'

# TODO add tiling-assistant keybindings

gsettings --schemadir "${SCHDIR}/workspaces-by-open-apps@favo02.github.com/schemas" \
    set org.gnome.shell.extensions.workspaces-indicator-by-open-apps indicator-show-background "true"

gsettings --schemadir "${SCHDIR}/workspaces-by-open-apps@favo02.github.com/schemas" \
    set org.gnome.shell.extensions.workspaces-indicator-by-open-apps scroll-enable "false"

# system-monitor-next@paradoxxx.zero.gmail.com
gsettings --schemadir "${SCHDIR}/system-monitor-next@paradoxxx.zero.gmail.com/schemas" \
    set org.gnome.shell.extensions.system-monitor-next-applet show-tooltip 'true'
gsettings --schemadir "${SCHDIR}/system-monitor-next@paradoxxx.zero.gmail.com/schemas" \
    set org.gnome.shell.extensions.system-monitor-next-applet rotate-labels 'true'
gsettings --schemadir "${SCHDIR}/system-monitor-next@paradoxxx.zero.gmail.com/schemas" \
    set org.gnome.shell.extensions.system-monitor-next-applet cpu-system-color '#c01c28ff'

# tilingshell@ferrarodomenico.com
gsettings --schemadir "${SCHDIR}/tilingshell@ferrarodomenico.com/schemas" \
    set org.gnome.shell.extensions.tilingshell enable-move-keybindings 'false'

# TODO - this setting probably also sets and unsets stuff in org.gnome.mutter -
# test whether setting these two values in tiling shell is consistent and behaves
# the same as setting them in the Extension settings app (if not correct that)
# I probably need to do more
gsettings --schemadir "${SCHDIR}/tilingshell@ferrarodomenico.com/schemas" \
    set org.gnome.shell.extensions.tilingshell overridden-settings '{"org.gnome.mutter":{"edge-tiling":"false"}}'

# window-title-is-back@fthx
gsettings --schemadir "${SCHDIR}/window-title-is-back@fthx/schemas" \
    set org.gnome.shell.extensions.window-title-is-back fixed-width 'false'

# /org/gnome/shell/extensions/auto-move-windows/application-list
# ['org.gnome.Nautilus.desktop:3', 'com.sindresorhus.Caprine.desktop:4', 'snap-store_snap-store.desktop:7', 'gparted.desktop:7', 'code.desktop:2', 'chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Profile_3.desktop:4', 'org.signal.Signal.desktop:4', 'chrome-hpfldicfbfomlpcikngkocigghgafkph-Profile_3.desktop:4', 'gnome-session-properties.desktop:7', 'nvidia-settings.desktop:7', 'update-manager.desktop:7', 'org.gnome.tweaks.desktop:7', 'gnome-system-panel.desktop:7', 'org.gnome.SystemMonitor.desktop:7', 'software-properties-gtk.desktop:7', 'gnome-printers-panel.desktop:7', 'org.gnome.baobab.desktop:7', 'chrome-bbdeiblfgdokhlblpgeaokenkfknecgl-Profile_3.desktop:4']
# /org/gnome/desktop/interface/enable-animations  false
# /org/gnome/shell/extensions/tilingshell/overridden-settings
#  '{"org.gnome.mutter":{"edge-tiling":"false"}}'

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
