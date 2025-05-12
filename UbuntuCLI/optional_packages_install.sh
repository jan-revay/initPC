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
    # php is required by phoronix test suite
    # todo fix php on ubuntu 22.04
    stressapptest stress-ng inxi

    # phoronix-test-suite dependencies
    php8.3 php-xml php8.3-xml
    php-gd php-bz2 php-sqlite3 php-curl
    mpicc libpopt-dev
)

time sudo apt-get install -y "${OPT_APT_PACKAGES[@]}"

wget -P /tmp/ https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.8.4/phoronix-test-suite_10.8.4_all.deb
sudo dpkg -i /tmp/phoronix-test-suite_10.8.4_all.deb

rm /tmp/phoronix-test-suite_10.8.4_all.deb

phoronix-test-suite batch-install pts/disk
