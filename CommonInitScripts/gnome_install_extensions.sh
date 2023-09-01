#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# This script should be idempotent.
# This script REQUIRES USER INTERACTION IN GNOME!!!

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

# ===== GNOME EXTENSIONS =====

# org.gnome.Shell.Extensions.InstallRemoteExtension() is the same DBus method that is used in the
# gnome-browser-connector package (the package that installs extesions via Chrome/Firefox plugin)
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

install_gnome_extension "scroll-workspaces@gfxmonk.net"
install_gnome_extension "Vitals@CoreCoding.com"
install_gnome_extension "hide-universal-access@akiirui.github.io"
install_gnome_extension "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
# TODO Do some research whether there is not some better workspace indicator.
install_gnome_extension "this.simple-indication-of-workspaces@azate.email"

# TODO Gnome extensions to try
# - some new clipboard manager
