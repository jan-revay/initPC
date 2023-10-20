#!/bin/bash -x
# The script should not require any user input and should be idempotent.

. ../prelude.sh

# consider avoiding or ifdefing snaps as they cannot be used in containers

# list install is not idempotent for some reason - TODO fix
# SNAP_PACKAGES+=(dust procs onefetch) -
# TODO benchmark the performance of snap vs. cargo
# rust packages and maybe switch back to cargo
# but install specific versions so that the script
# will not break easily.
time sudo snap install dust
time sudo snap install procs
time sudo snap install onefetch
time sudo snap install helix --classic
