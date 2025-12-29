#!/bin/bash
. ../prelude.sh

pushd RootDotfiles/

CROND_FILES=(./daily_schutdown_schedule/etc/cron.d/daily_shutdown_schedule
    ./spin_hdd_off/etc/cron.d/spin_hdd_off
)

sudo chown root:root "${CROND_FILES[@]}"
sudo chmod 644 "${CROND_FILES[@]}"

if ! stow -vvv --no --target=/ MX3_MASTER_LOGID_CONFIG/; then
    sudo mv /etc/logid.cfg /etc/logid.cfg-initPCBackup"$(date '+%Y%m%d_%H%M%S')"
fi

# TODO - modify dirs_to_stow based on platform (e.g. VM)
dirs_to_stow=(disable_highres_scroll
    MX3_MASTER_LOGID_CONFIG
    spin_hdd_off
    daily_schutdown_schedule
)

# Stow each directory
for dir in "${dirs_to_stow[@]}"; do
    sudo stow -vvv --target=/ "$dir"/
done

popd
