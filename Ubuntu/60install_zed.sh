#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# TODO - also check dependencies (glibc)
# strings ~/.local/kitty.app/bin/kitty | grep -o 'GLIBC_[0-9.]*' | sort -V | tail -1
# ldd --version
# glibc kitty was built against needs to be older than the current glibc
# also check other dependencies
# TODO - could this cause compatibility issues (e.g. glibc ? - do research)
install_zed()
{
    curl -f https://zed.dev/install.sh | sh

}
install_zed
