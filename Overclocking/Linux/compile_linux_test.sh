#!/bin/bash -x

sudo apt-get install -y build-essential libncurses-dev bison flex libssl-dev libelf-dev bc
git clone https://github.com/torvalds/linux.git
cd linux/ || exit 1
git checkout cd2e103d57e5615f9bb027d772f93b9efd567224 # 1.6. 2025

make clean > /dev/null
make defconfig

sleep 30
make clean > /dev/null
time make -j"$(nproc)" > /dev/null
make clean > /dev/null
sleep 30
time make -j"$(nproc)" > /dev/null
make clean > /dev/null
sleep 30
time make -j"$(nproc)" > /dev/null
make clean > /dev/null
sleep 30
