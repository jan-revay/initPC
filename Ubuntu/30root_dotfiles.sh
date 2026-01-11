#!/bin/bash
. ../prelude.sh
# NOTE: "${name[@]}" expands each element of name to a separate word. See:
# https://www.gnu.org/software/bash/manual/bash.html?utm_source=chatgpt.com#Arrays

clean()
{
    local -r TO_CLEAN=(
        /etc/cron.d/daily_shutdown_schedule
        /etc/cron.d/spin_hdd_off
        /etc/libinput/local-overrides.quirks
    )
    # Delete links to files created by this script
    sudo rm -f "${TO_CLEAN[@]}"
    # Backup old logid.cfg
    if ! stow -vvv --no --target=/ MX3_MASTER_LOGID_CONFIG/; then
        sudo mv /etc/logid.cfg /etc/logid.cfg-initPCBackup"$(date '+%Y%m%d_%H%M%S')"
    fi
}

permissions()
{
    local -r CROND_FILES=(
        ./daily_schutdown_schedule/etc/cron.d/daily_shutdown_schedule
        ./spin_hdd_off/etc/cron.d/spin_hdd_off
    )

    # TODO anytime git touches these files, permissions will be messed up?
    # Is it ok? Consider copying directly.
    sudo chown root:root "${CROND_FILES[@]}"
    sudo chmod 644 "${CROND_FILES[@]}"
}

stow_all()
{
    # TODO - modify dirs_to_stow based on platform (e.g. VM)
    local -r DIRS_TO_STOW=(
        MX3_MASTER_LOGID_CONFIG
        daily_schutdown_schedule
        disable_highres_scroll
        spin_hdd_off
    )

    sudo stow -vvv --target=/ "${DIRS_TO_STOW[@]}"
}

# We create libinput dir explicitly instead of just linking to it with stow,
# so that we can clean just the file we stowed there (the dir might be used
# by other utils as well), we don't want stow to own the whole directory.
sudo mkdir -p /etc/libinput

pushd RootDotfiles/
clean
permissions
stow_all
popd
