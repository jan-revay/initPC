#!/bin/bash
. ../prelude.sh
# The script should not require any user input and should be idempotent.
# TODO apt-get install linux-headers-$(uname -r) does not work in WSL
# TODO move the package lists to external files
# TODO add repos and packates that PopOS has: https://pop.system76.com/

mkdir -p ~/localSW
pushd ~/localSW/

# TODO try using a more efficient method e.g. just pulling and just recompiling
rm -rf ydotool
git clone https://github.com/ReimuNotMoe/ydotool.git
pushd ydotool
mkdir build
pushd build
time cmake ..
time make -j "$(nproc)"
sudo make install
popd
popd

if ydotoold --version; then
    systemctl --user enable ydotoold.service
else
    echo "ydotoold installation failed"
    exit 1
fi

# TODO Focusrite drivers
# git clone https://github.com/geoffreybennett/alsa-scarlett-gui.git

popd
