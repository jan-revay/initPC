#!/bin/bash -x
# Stuff that requires user interaction and cannot be done by a script yet.
# This script is being run first i.e. before anything else, so that all
# user interaction is finished as quickly as possible.

. ../prelude.sh

function interactive_part
{
    if ! gh auth status; then
        read -r -s -p "GitHub token: " GITHUB_TOKEN # TODO add a check for empty token
        echo # add newline
        sudo apt-get -y update
        sudo apt-get install -y gh
        echo "${GITHUB_TOKEN}" | gh auth login --hostname github.com --with-token
        gh config set git_protocol https --host github.com
        # With the next line, the result of `gh auth login` is exactly the same as
        # if we used the interactive version. The authentication on Ubuntu 22.04
        # does not work without it. The noninteractive version does not set user for
        # some reason (probably a bug TODO report it).
        # TODO - only echo if user is not already set
        echo "    user: jan-revay" >> ~/.config/gh/hosts.yml
        gh auth setup-git
    fi
}

# TODO improve parameter parsing - move it to platform independent code
if [ "$1" = "--help" ]; then
    echo "usage: ./run_all.sh [--noninteractive]"
    echo
    # shellcheck disable=SC2016
    echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
    exit ${EXIT_SUCCESS}
fi

if [ "$1" == "--noninteractive" ]; then
    echo "Skipping interactive commands as $1 parameter was provided"
elif [ "$1" == "" ]; then
    interactive_part
else
    echo "invalid argument $1"
    exit ${EXIT_INVALID_ARGUMENT}
fi
