#!/bin/bash -x
# The script should not require any user input and should be idempotent.

# TODO add:
#    - zig compiler and language server
#    - rust compiler
#    - ICC and AOCC (Intel and AMD C++ compilers)
# add foliate: sudo apt install foliate
#    - powershell https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.3

. ../prelude.sh

OPT_APT_PACKAGES=(
    # stress testing and benchmarking tools
    stressapptest stress-ng inxi
)

time sudo apt-get install -y "${OPT_APT_PACKAGES[@]}"

wget -P /tmp/ https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.8.4/phoronix-test-suite_10.8.4_all.deb
sudo dpkg -i /tmp/phoronix-test-suite*
rm /tmp/phoronix-test-suite*
