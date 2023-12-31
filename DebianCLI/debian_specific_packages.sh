#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# Packages that are installed on Ubuntu, but not available on Debian (e.g. PPAs)
# are installed here.

# TODO try installing these packages as snaps (therefore using the same script
# for Debian and Ubuntu)

. ../prelude.sh

cd ~/x/

if ! test -d helix; then
    git clone https://github.com/helix-editor/helix
fi

cd helix
git pull
cargo install --path helix-term --locked
mkdir -p ~/.config/helix/
# TODO fix hx --Health warning:
# `Runtime directory does not exist: /home/jr/.cargo/bin/runtime`
# TODO fix recursive runtime directory nesting
ln -f -s "$PWD/runtime" ~/.config/helix/runtime
hx --grammar fetch
hx --grammar build
hx --health
# TODO add find "${CRAFT_PART_INSTALL}" -type f -executable -exec strip {} \;
#TODO - have a look at here: https://github.com/helix-editor/helix/tree/master/.github/workflows

# TODO - do I need to use --force parameter to update cargo packages?
# see: https://github.com/o2sh/onefetch/wiki/Installation#cargo
# TODO enable systemd and install these via snaps - that way I can use identical install script
# for ubuntu and debian (don't forget to make writing /etc/wsl.conf idempotent)
# TODO - uncomment broken packages and add specific versions (so that they compile ok)
cargo install du-dust # onefetch procs  - temporary broken (won't compile)
