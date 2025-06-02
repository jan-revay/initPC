#!/bin/bash -x

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
