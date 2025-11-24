#!/bin/bash -x
# The script should not require any user input and should be idempotent.

. ../prelude.sh

# ==== Misc ====
sudo update-alternatives --set editor /usr/bin/nvim
