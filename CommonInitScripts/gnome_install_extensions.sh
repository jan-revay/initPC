#!/bin/bash -x
# This script should be idempotent.
# This script REQUIRES USER INTERACTION IN GNOME!!!
#
# TODO add extension settings
# Consider this: https://github.com/PeterMosmans/ansible-role-customize-gnome

. ../prelude.sh

# TODO Another session manager extension can probably replace putwindows and
# also my autostart scripts as it is also able to start the applications.
# TODO more research wrt the Another session manager extension and also consider manually
# scripting window layout rules with tools such as devilspie2 or wmctrl

# ===== GNOME EXTENSIONS =====

# TODO consider these extensions: https://youtube.com/watch?v=wtjeaL90E6Q&si=VQmzns96n-dI6eL0 and
# extensions used in Nobara project (Linux distro)
# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extensions via Chrome/Firefox plugin)
# TODO add extensions from this video: https://youtu.be/KtjYPMCvQ7Y?si=sAPoExRbWvSI5g3s
# TODO consider some taskbar extension so that I don't normally need to use the GNOME dock

## @note the gdbus call InstallRemoteExtension() might need to be invoked twice
## as sometimes the first call fails.
function install_gnome_extension
{
    local EXTENSION_ID="$1"

    # I am preserving the interactive version because gext webpage says that using the --filesystem
    # method "some extensions might not install well"
    # TODO remove the if-else - gext should be able to detect running gnome session by itself.
    # see https://github.com/essembeh/gnome-extensions-cli?tab=readme-ov-file#under-the-hood-dbus-vs-filesystem
    if [ "${NONINTERACTIVE}" == 'true' ]; then
        gnome-extensions-cli --filesystem --no-color install "${EXTENSION_ID}"
    else
        gnome-extensions-cli install "${EXTENSION_ID}"
    fi

    # TODO some extensions do not compile their schemas on the installation hence we compile them
    # manually. TODO investigate and remove if fixed.
    # TODO make sure that this is also done correctly when extension is updated resp. if I rerun
    # this code and the extension is already installed
    glib-compile-schemas "${HOME}/.local/share/gnome-shell/extensions/${EXTENSION_ID}/schemas" || true

    #    OLD code - needs user interaction and hence breaks CI TODO DELETE
    #    # TODO test whether all extensions are installed the first call
    #    # if not, call gdbus in a while loop
    #    if ! gnome-extensions list | grep "${EXTENSION_ID}"; then
    #        gdbus call --session --dest org.gnome.Shell.Extensions \
    #            --object-path /org/gnome/Shell/Extensions \
    #            --method org.gnome.Shell.Extensions.InstallRemoteExtension \
    #            "${EXTENSION_ID}"
    #    fi
}

# TODO add https://extensions.gnome.org/extension/4356/top-bar-organizer/ ?
# TODO add https://extensions.gnome.org/extension/3843/just-perfection/
install_gnome_extension "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
install_gnome_extension "clipboard-history@alexsaveau.dev"
install_gnome_extension "focus-changer@heartmire"
install_gnome_extension "focus@scaryrawr.github.io"
install_gnome_extension "grand-theft-focus@zalckos.github.com"
# install_gnome_extension "improved-workspace-indicator@michaelaquilina.github.io" # - outdated for Ubuntu 25.04
# install_gnome_extension "lilypad@shendrew.github.io"
# TODO - consider adding back...?
install_gnome_extension "middleclickclose@paolo.tranquilli.gmail.com"
install_gnome_extension "panelScroll@sun.wxg@gmail.com"
install_gnome_extension "quake-terminal@diegodario88.github.io"
# install_gnome_extension "reminder_alarm_clock@trifonovkv.gmail.com" # - outdated for Ubuntu 25.04
# install_gnome_extension "switcher@landau.fi" # - outdated for Ubuntu 25.04
install_gnome_extension "system-monitor-next@paradoxxx.zero.gmail.com"
install_gnome_extension "tilingshell@ferrarodomenico.com"
install_gnome_extension "transparent-window-moving@noobsai.github.com"
install_gnome_extension "ubuntu-dock@ubuntu.com"
install_gnome_extension "undecorate@sun.wxg@gmail.com"
install_gnome_extension "Vitals@CoreCoding.com"
install_gnome_extension "weeks-start-on-monday@extensions.gnome-shell.fifi.org"
install_gnome_extension "window-calls@domandoman.xyz"
install_gnome_extension "window-title-is-back@fthx"
# TODO - find alterantive
# install_gnome_extension "windowIsReady_Remover@nunofarruca@gmail.com" # - outdated for Ubuntu 25.04
install_gnome_extension "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
install_gnome_extension "workspaces-by-open-apps@favo02.github.com"
install_gnome_extension "hide-universal-access@akiirui.github.io"
# TODO jut perfection extension can do that as well and is more universal...
# I can be doing this via Lilpad
# TODO consider whether it is a good idea as if the icons will fit, I can see them always
# and if they would not fit, lilpad will not help with that anyway...
install_gnome_extension "highlight-focus@pimsnel.com"

# DISABLE extensions

gnome-extensions disable ding@rastersoft.com

# install_gnome_extension "scroll-workspaces@gfxmonk.net"
# install_gnome_extension "Vitals@CoreCoding.com"
# install_gnome_extension "hide-universal-access@akiirui.github.io"
# install_gnome_extension "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
# TODO Do some research on whether there is a better workspace indicator.
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
# reminder_alarm_clock@trifonovkv.gmail.com # - outdated for Ubuntu 25.04
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
