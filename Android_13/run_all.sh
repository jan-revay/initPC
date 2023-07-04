#!/bin/bash -x
# BASE IMAGE: Android 13

set -e

# TODO add check for android

./packages_install.sh
./configs_install.sh

