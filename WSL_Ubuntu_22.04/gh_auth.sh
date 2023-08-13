#!/bin/bash
# bash debug mode is off - as we don't want to leak the token
# BASE IMAGE: WSL Ubuntu 22.04
# REQUIRES A USER INPUT

read -sp 'Enter GitHub authentication token: ' TOKEN
readonly TOKEN

echo \
"github.com:
    oauth_token: "${TOKEN}"
    user: jan-revay
    git_protocol: https" \
> /home/jr/.config/gh/hosts.yml

echo "${TOKEN}" | gh auth login --with-token
# gh config set -h github.com git_protocol https
echo
echo Logged in to guthub.com
