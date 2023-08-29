#!/bin/bash -x
# BASE IMAGE: WSL Ubuntu 22.04
# Stuff that requires user interaction and cannot be done by a script yet.
# This script is being run first i.e. before anything else, so that all
# user interaction is finished as quickly as possible.

# makes the echo prompt yellow to improve readability
export PS4="\[\033[1;93m\]+ \[\033[0m\]"
set -e # exit on error

function interactive_part
{
    # WARNING: gh auth login --with-token is somehow broken (git asks for pw anyway)
    if ! gh auth status; then
        read -s -p "GitHub token: " GITHUB_TOKEN
        sudo apt-get -y update
        sudo apt-get install -y gh
        echo # add newline
        echo "${GITHUB_TOKEN}" | gh auth login --hostname github.com --with-token
        gh config set git_protocol https --host github.com
        echo "    user: jan-revay" >> ~/.config/gh/hosts.yml
        gh auth --setup-git
    fi
}

if [ "$1" = "--help" ]; then
    echo "usage: ./run_all.sh [--noninteractive]"
    echo
    # shellcheck disable=SC2016
    echo '--noninteractive  skip stuff requiring user interaction (e.g. `gh auth login`)'
    exit 0
fi

if [ "$1" == "--noninteractive" ]; then
    echo "Skipping interactive commands as $1 parameter was provided"
elif [ "$1" == "" ]; then
    interactive_part
else
    echo "invalid argument $1"
    exit 1
fi
