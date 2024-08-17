#!/bin/bash -x
# This script should be idempotent.
# This script REQUIRES USER INTERACTION IN GNOME!!!
#
# TODO add extension settings
# Consider this: https://github.com/PeterMosmans/ansible-role-customize-gnome

. ../prelude.sh

sudo apt-get install gir1.2-gtop-2.0 # needed by some performance monitoring extensions

# TODO Another session manager extension can probably replace putwindows and
# also my autostart scripts as it is also able to start the applications.
# TODO more research wrt the Another session manager extension and also consider manually
# scripting window layout rules with tools such as devilspie2 or wmctrl

# ===== GNOME EXTENSIONS =====

# TODO consider these extensions: https://youtube.com/watch?v=wtjeaL90E6Q&si=VQmzns96n-dI6eL0 and
# extensions used in Nobara project (linux distro)
# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extesions via Chrome/Firefox plugin)
# TODO add extensions from this video: https://youtu.be/KtjYPMCvQ7Y?si=sAPoExRbWvSI5g3s
# TODO consider some taskbar extension so that I don't neormally need to use GNOME dock

## @note the gdbus call InstallRemoteExtension() might need to be invoked twice
## as sometimes the first call fails.
function install_gnome_extension
{
    local EXTENSION_ID="$1"

    # TODO test whether all extensions are installed the first call
    # if not, call gdbus in a while loop
    if ! gnome-extensions list | grep "${EXTENSION_ID}"; then
        gdbus call --session --dest org.gnome.Shell.Extensions \
            --object-path /org/gnome/Shell/Extensions \
            --method org.gnome.Shell.Extensions.InstallRemoteExtension \
            "${EXTENSION_ID}"
    fi
}

echo "Warning - extensions temporary disabled (because of new GNOME version)"

# TODO find extension for clipboard management

# install_gnome_extension "scroll-workspaces@gfxmonk.net"
# install_gnome_extension "Vitals@CoreCoding.com"
# install_gnome_extension "hide-universal-access@akiirui.github.io"
# install_gnome_extension "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
# TODO Do some research whether there is not some better workspace indicator.
# TODO experimental extensions - TODO - evaluate
# install_gnome_extension "this.simple-indication-of-workspaces@azate.email"
# install_gnome_extension "quake-mode@repsac-by.github.com"

# TODO Gnome extensions to try
# - some new clipboard manager
#
#
# Extensions to maybe add:
# windowsNavigator@gnome-shell-extensions.gcampax.github.com
# stopwatch@aliakseiz.github.com
# rclone-manager@germanztz.com
# arrangeWindows@sun.wxg@gmail.com
# smart-auto-move@khimaros.com
# rclone-manager@germanztz.com
# Vitals@CoreCoding.com
# windowsNavigator@gnome-shell-extensions.gcampax.github.com
# stopwatch@aliakseiz.github.com
# reminder_alarm_clock@trifonovkv.gmail.com
# hide-universal-access@akiirui.github.io
# transparent-window-moving@noobsai.github.com
# window-list@gnome-shell-extensions.gcampax.github.com
# burn-my-windows@schneegans.github.com
# all-windows-srwp@jkavery.github.io
# order-extensions@wa4557.github.com
# improved-workspace-indicator@michaelaquilina.github.io
# quake-terminal@diegodario88.github.io
# ding@rastersoft.com
# tiling-assistant@ubuntu.com
# ubuntu-appindicators@ubuntu.com
# ubuntu-dock@ubuntu.com
# panelScroll@sun.wxg@gmail.com
#
#
#
# arrangeWindows@sun.wxg@gmail.com
# panelScroll@sun.wxg@gmail.com
# smart-auto-move@khimaros.com
# rclone-manager@germanztz.com
# Vitals@CoreCoding.com
# windowsNavigator@gnome-shell-extensions.gcampax.github.com
# stopwatch@aliakseiz.github.com
# reminder_alarm_clock@trifonovkv.gmail.com
# hide-universal-access@akiirui.github.io
# transparent-window-moving@noobsai.github.com
# window-list@gnome-shell-extensions.gcampax.github.com
# burn-my-windows@schneegans.github.com
# all-windows-srwp@jkavery.github.io
# order-extensions@wa4557.github.com
# improved-workspace-indicator@michaelaquilina.github.io
# quake-terminal@diegodario88.github.io
# focus@scaryrawr.github.io
# focus-changer@heartmire
# highlight-focus@pimsnel.com
# workspaces-by-open-apps@favo02.github.com
# ding@rastersoft.com
# tiling-assistant@ubuntu.com
# ubuntu-appindicators@ubuntu.com
# ubuntu-dock@ubuntu.com
# clipboard-history@alexsaveau.dev

# arrangeWindows@sun.wxg@gmail.com
# panelScroll@sun.wxg@gmail.com
# smart-auto-move@khimaros.com
# rclone-manager@germanztz.com
# Vitals@CoreCoding.com
# windowsNavigator@gnome-shell-extensions.gcampax.github.com
# stopwatch@aliakseiz.github.com
# reminder_alarm_clock@trifonovkv.gmail.com
# hide-universal-access@akiirui.github.io
# transparent-window-moving@noobsai.github.com
# window-list@gnome-shell-extensions.gcampax.github.com
# burn-my-windows@schneegans.github.com
# order-extensions@wa4557.github.com
# improved-workspace-indicator@michaelaquilina.github.io
# quake-terminal@diegodario88.github.io
# another-window-session-manager@gmail.com
# focus@scaryrawr.github.io
# focus-changer@heartmire
# highlight-focus@pimsnel.com
# workspaces-by-open-apps@favo02.github.com
# all-windows@ezix.org
# auto-move-windows@gnome-shell-extensions.gcampax.github.com
# clipboard-history@alexsaveau.dev
# weeks-start-on-monday@extensions.gnome-shell.fifi.org
# ding@rastersoft.com
# tiling-assistant@ubuntu.com
# ubuntu-appindicators@ubuntu.com
# ubuntu-dock@ubuntu.com
# system-monitor-next@paradoxxx.zero.gmail.com
# vertical-window-list@student.gitlab.com
# dim-background-windows@stephane-13.github.com
# grand-theft-focus@zalckos.github.com
# window-title-is-back@fthx
#
# List as of 13.8.2024
#
# arrangeWindows@sun.wxg@gmail.com
# panelScroll@sun.wxg@gmail.com
# smart-auto-move@khimaros.com
# rclone-manager@germanztz.com
# Vitals@CoreCoding.com
# windowsNavigator@gnome-shell-extensions.gcampax.github.com
# stopwatch@aliakseiz.github.com
# reminder_alarm_clock@trifonovkv.gmail.com
# hide-universal-access@akiirui.github.io
# transparent-window-moving@noobsai.github.com
# window-list@gnome-shell-extensions.gcampax.github.com
# burn-my-windows@schneegans.github.com
# order-extensions@wa4557.github.com
# improved-workspace-indicator@michaelaquilina.github.io
# quake-terminal@diegodario88.github.io
# another-window-session-manager@gmail.com
# focus@scaryrawr.github.io
# focus-changer@heartmire
# highlight-focus@pimsnel.com
# workspaces-by-open-apps@favo02.github.com
# all-windows@ezix.org
# auto-move-windows@gnome-shell-extensions.gcampax.github.com
# clipboard-history@alexsaveau.dev
# weeks-start-on-monday@extensions.gnome-shell.fifi.org
# grand-theft-focus@zalckos.github.com
# dim-background-windows@stephane-13.github.com
# system-monitor-next@paradoxxx.zero.gmail.com
# window-title-is-back@fthx
# ding@rastersoft.com
# tiling-assistant@ubuntu.com
# ubuntu-appindicators@ubuntu.com
# ubuntu-dock@ubuntu.com
# workspace-indicator@gnome-shell-extensions.gcampax.github.com
# panel-workspace-scroll@polymeilex.github.io
#
