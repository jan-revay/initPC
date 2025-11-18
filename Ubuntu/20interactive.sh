#!/bin/bash -x
# Stuff that requires user interaction and cannot be done by a script yet.
# This script is being run first i.e. before anything else, so that all
# user interaction is finished as quickly as possible.

. ../prelude.sh

. ../DistroAgnostic/gnome_install_extensions.sh
