#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# Stuff that requires user interaction and cannot be done by a script yet.
# This script is being run first i.e. before anything else, so that all
# user interaction is finished as quickly as possible.

. ../prelude.sh

. ../WSL_Ubuntu_22.04/interactive_part.sh

# GNOME extensions
. ../CommonInitScripts/gnome_install_extensions.sh

# TODO configure postfix in advance from command line
# TODO what is this app and why does it automatically install itself on Ubuntu
# server/desktop, but not in wsl? It needs user interaction hence adding it here.
sudo apt-get install -y postfix
