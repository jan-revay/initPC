#!/bin/bash
. ../prelude.sh
# NOTE: "${name[@]}" expands each element of name to a separate word. See:
# https://www.gnu.org/software/bash/manual/bash.html?utm_source=chatgpt.com#Arrays
# TODO: refactor this to be less hacky. Ideally I should need no clean step and
# no exact paths. (turning packages on and off can be done by straight deletion
# of the directory subtree)
# Ideally I would just set permissions and stow everyting...

clean()
{
    local -r TO_CLEAN=(
        /etc/cron.d/horarium
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

cron_permissions()
{
    local -r CROND_FILES=(
        ./horarium/etc/cron.d/*
        ./spin_hdd_off/etc/cron.d/*
    )

    # TODO anytime git touches these files, permissions will be messed up?
    # Is it ok? Consider copying directly.
    # consider sudo install -m 644 -o root -g root source /etc/cron.d/file
    # TODO consider what to do if a file does not exists
    sudo chown root:root "${CROND_FILES[@]}"
    sudo chmod 644 "${CROND_FILES[@]}"
}

# We create libinput dir explicitly instead of just linking to it with stow,
# so that we can clean just the file we stowed there (the dir might be used
# by other utils as well), we don't want stow to own the whole directory.
sudo mkdir -p /etc/libinput

pushd RootDotfiles/

clean
cron_permissions
sudo stow -vvv --target=/ -- *
popd
