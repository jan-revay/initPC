#!/bin/bash -x

. ../prelude.sh

# TODO add Nix package manager & nix packages

# TODO decide between flatpaks and snaps (or combine them)
# TODO VSC flatpak appears to be broken and lower quality than the snap
# TODO test the flatpaks

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

readonly FLATPAK_PACKAGES=(
    com.visualstudio.code
    com.github.johnfactotum.Foliate
    org.signal.Signal
    com.sindresorhus.Caprine
    com.spotify.Client
    com.axosoft.GitKraken
)

readonly SNAP_PACKAGES=(
    core
    snap-store
    todoist
)

# TODO reloading bashrc might be needed (SNAP)
# TODO verify Installing snaps from a list is not idempotent for some reason TODO try fixing
time sudo snap refresh
time print0 "${SNAP_PACKAGES[@]}" | xargs -0 -I % sudo snap install %

time flatpak install --noninteractive --assumeyes flathub "${FLATPAK_PACKAGES[@]}"
