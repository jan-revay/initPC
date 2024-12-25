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
elif [ "$1" == "" ]; then
    echo "Executing the interactive part..."
fi

. ../CommonInitScripts/gnome_install_extensions.sh
