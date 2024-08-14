#!/bin/bash -x

. ../prelude.sh

# TODO add Nix package manager & nix packages

# TODO decide between flatpaks and snaps (or combine them)
# TODO VSC flatpak appears to be broken and lower quality than the snap
# TODO test the flatpaks

# TODO - is this needed?
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# TODO toread https://man7.org/linux/man-pages/man1/flatpak-install.1.html
readonly FLATPAK_PACKAGES=(
    com.visualstudio.code
    com.github.johnfactotum.Foliate
    org.signal.Signal
    com.sindresorhus.Caprine
    com.spotify.Client
    com.axosoft.GitKraken
)
time flatpak install --noninteractive --assumeyes flathub "${FLATPAK_PACKAGES[@]}"

# TODO verify Installing snaps from a list is not idempotent for some reason TODO try fixing
# TODO reloading bashrc might be needed (SNAP)
readonly SNAP_PACKAGES=(
    core
    snap-store
    todoist
)
time sudo snap refresh
time print0 "${SNAP_PACKAGES[@]}" | xargs -0 -I % sudo snap install %
