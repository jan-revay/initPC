#!/bin/bash -x
# This script should be idempotent.

. ../prelude.sh

distro_is ubuntu
distro_version_ge 22
gnome_present yes

# TODO fix the script and remove
echo "This script is not yet finished therefore disabled (to prevent incorrect\
configs and CI failing on known bugs)."
exit 1

# TODO "Which services should be restarted?" prompt is still present in VM
# TODO - is this relevant in Ubuntu desktop (seems to only do sth. in Ubuntu server)
# TODO - move to packages_install.sh
export NEEDRESTART_MODE=a
export NEEDRESTART_SUSPEND=1

sudo apt update
sudo apt install chrome-gnome-shell
# TODO move elsewhere...
mkdir -p ~/tmp
pushd ~/tmp
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub > linux_signing_key.pub
sudo install -D -o root -g root -m 644 linux_signing_key.pub /etc/apt/keyrings/linux_signing_key.pub
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/linux_signing_key.pub] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable
popd

# Run stuff that requires user input first (if not turned off by `--noninteractive`)
. interactive_part.sh
. packages_install.sh
. ../UbuntuCLI/ubuntu_specific_packages.sh
. configs_install.sh

# todo - is this automatic restart really needed?
echo "INIT SCRIPT FINISHED SUCCESSFULLY, REBOOTING IN 30 SECONDS..."
sleep 30
reboot
