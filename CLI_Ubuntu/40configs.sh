#!/bin/bash
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# ==== Misc ====
sudo update-alternatives --set editor /usr/bin/nvim
