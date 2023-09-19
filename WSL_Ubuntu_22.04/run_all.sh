#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# This script should be idempotent.

. ../prelude.sh

# TODO Ubuntu 23.04 works, hence it can be allowed, make this official
# TODO try enabling 2x in general - this did not work - some packages are not available on 20.04
# TODO try enabling 22.04 + (ideally by explicit naming)
if [[ "$(lsb_release --description --short)" != 'Ubuntu 22.04'* &&
"$(lsb_release --description --short)" != 'Ubuntu 23.04'* ]]; then
    echo 'Error: The base image does not match "Ubuntu 22.04"! Aborting.' >&2
    exit ${EXIT_INCORRECT_PLATFORM}
fi

# TODO remove resp. rename the script directory
# if ! uname -r | grep "WSL2"; then
#     echo "Warning: The base image probably does not run in WSL."
#     exit 2
# fi

if gnome-extensions --version; then
    echo 'Use Ubuntu Desktop installer (./Ubuntu_22.04)' >&2
    echo 'This script is targeted only to CLI installations' >&2
    exit ${EXIT_INCORRECT_PLATFORM}
fi

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. interactive_part.sh

. ubuntu_specific_packages.sh

. packages_install.sh

# . packages_install_optional.sh

. configs_install.sh
