#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# The script should not require any user input and should be idempotent.

sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo apt-get update

APT_PACKAGES=(helix)
sudo apt-get install -y "${APT_PACKAGES[@]}"
