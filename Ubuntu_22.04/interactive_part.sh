#!/bin/bash -x
# Stuff that requires user interaction and cannot be done by a script yet.
# This script is being run first i.e. before anything else, so that all
# user interaction is finished as quickly as possible.

. ../prelude.sh

. ../UbuntuCLI/interactive_part.sh

# TODO racionalize parameter handling (`--help` and invalid parameters are handled in UbuntuCLI)
# TODO -- refactor parameter handling and initialization of the NONINTERACTIVE global variable
if [ "$1" == "--noninteractive" ]; then
    readonly NONINTERACTIVE='true'
    echo "Skipping interactive commands as $1 parameter was provided"
    # TODO try configuring postfix noninteractively
    # TODO format the code nicer...
    sudo debconf-set-selections <<EOF
    postfix postfix/main_mailer_type select No configuration
EOF
    sudo apt-get install -y postfix
elif [ "$1" == "" ]; then
    # GNOME extensions
    # TODO configure postfix in advance from command line
    # TODO what is this app and why does it automatically install itself on Ubuntu
    # server/desktop, but not in wsl? It needs user interaction hence adding it here.
    sudo apt-get install -y postfix ttf-mscorefonts-installer
fi

. ../CommonInitScripts/gnome_install_extensions.sh
