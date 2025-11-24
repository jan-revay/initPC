#!/bin/bash -x
# The script should not require any user input and should be idempotent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL
# TODO move the package lists to external files
# TODO add repos and packates that PopOS has: https://pop.system76.com/
. ../prelude.sh

pushd ~/localSW/

git clone https://github.com/ReimuNotMoe/ydotool.git
pushd ydotool
mkdir build
pushd build
time cmake ..
time make -j `nproc`
sudo make install
popd
popd

if ydotoold --version; then
    systemctl --user enable ydotool.service
else
    echo "ydotool installation failed"
    exit 1
fi


# TODO Focusrite drivers
# git clone https://github.com/geoffreybennett/alsa-scarlett-gui.git





popd
