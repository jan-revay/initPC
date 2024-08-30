#!/bin/bash -x

. ../prelude.sh

# TODO setup automatic flatpak and snap updates
# TODO skip install if running inside a docker container and print warning
# TODO print the text in color and review the code for Docker skipping.
# TODO maybe the way of detecting docker is not great (try improving)
if [ -f /.dockerenv ]; then
    echo "The initPC script is running inside a Docker container"
    echo "Skipping installation of flatpaks/snaps/appimages/nix packages"
else
    echo "The initPC script is not running inside Docker"
    echo "Installing flatpaks/snaps/appimages/nix packages"

    # TODO add Nix package manager & nix packages
    # maybe Nix packages can be used in Docker? TODO

    # TODO decide between flatpaks and snaps (or combine them)
    # TODO VSC flatpak appears to be broken and lower quality than the snap
    # TODO install VSC from a .deb package directly downloaded via website
    # or find other vay to install it via .deb
    # TODO test the flatpaks

    # TODO - is this needed?
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    flatpak update --assumeyes
    # TODO also update snaps

    # TODO toread https://man7.org/linux/man-pages/man1/flatpak-install.1.html
    readonly FLATPAK_PACKAGES=(
        com.visualstudio.code
        com.github.johnfactotum.Foliate
        org.signal.Signal
        com.sindresorhus.Caprine
        com.spotify.Client
        com.axosoft.GitKraken
    )
    # TODO try fixing flatpak installation without sudo (or at least do some research
    # whether the sudo will not break sth.)
    time sudo flatpak install --noninteractive --assumeyes flathub "${FLATPAK_PACKAGES[@]}"

    # TODO verify Installing snaps from a list is not idempotent for some reason TODO try fixing
    # TODO reloading bashrc might be needed (SNAP)
    # list install is not idempotent for some reason - TODO fix
    # TODO benchmark the performance of snap vs. cargo
    # rust packages and maybe switch back to cargo
    # but install specific versions so that the script
    # will not break easily.
    readonly SNAP_PACKAGES=(
        core
        snap-store
        todoist

        # TODO add the CLI packages to UbuntuCLI (but use different install method)
        dust
        procs
        onefetch
    )
    time sudo snap refresh
    time print0 "${SNAP_PACKAGES[@]}" | xargs -0 -I % sudo snap install %
    time sudo snap install helix --classic # TODO move to UbuntuCLI
    time sudo snap install gitkraken --classic
    time sudo snap install clion --classic

fi
