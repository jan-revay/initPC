#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo add-apt-repository -y ppa:o2sh/onefetch

APT_PACKAGES+=(helix onefetch)

SNAP_PACKAGES+=(du-dust procs)
sudo snap install "${SNAP_PACKAGES[@]}"
