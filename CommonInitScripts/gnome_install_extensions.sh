#!/bin/bash -x
# This script should be idempotent.
# This script REQUIRES USER INTERACTION IN GNOME!!!

. ../prelude.sh

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

# TODO find extension for clipboard management

install_gnome_extension "scroll-workspaces@gfxmonk.net"
install_gnome_extension "Vitals@CoreCoding.com"
install_gnome_extension "hide-universal-access@akiirui.github.io"
install_gnome_extension "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
# TODO Do some research whether there is not some better workspace indicator.
# TODO experimental extensions - TODO - evaluate
install_gnome_extension "this.simple-indication-of-workspaces@azate.email"
install_gnome_extension "quake-mode@repsac-by.github.com"

# TODO Gnome extensions to try
# - some new clipboard manager
