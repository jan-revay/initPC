#!/bin/bash -x
# The script should not require any user input and should be idempotent.

. ../prelude.sh

pushd ../CommonInitScripts/ || exit ${EXIT_FILE_IO_ERROR}
# TODO cd in sharedConfig.sh
# shellcheck source=/dev/null
. sharedConfig.sh
popd || exit ${EXIT_FILE_IO_ERROR}

# ==== Misc ====
sudo update-alternatives --set editor /usr/bin/nvim
