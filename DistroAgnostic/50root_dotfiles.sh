#!/bin/bash
. ../prelude.sh

pushd RootDotfiles/

if ! stow -vvv --no --target=/ MX3_MASTER_LOGID_CONFIG/; then
    sudo mv /etc/logid.cfg /etc/logid.cfg-initPCBackup"$(date '+%Y%m%d_%H%M%S')"
fi

# TODO - modify dirs_to_stow based on platform (e.g. VM)
dirs_to_stow=(disable_highres_scroll daily_schutdown_schedule MX3_MASTER_LOGID_CONFIG)

# Stow each directory
for dir in "${dirs_to_stow[@]}"; do
    sudo stow -vvv --target=/ "$dir"/
done

popd
