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
    stressapptest phoronix-test-suite stress-ng inxi
)

time sudo apt-get install -y "${OPT_APT_PACKAGES[@]}"
