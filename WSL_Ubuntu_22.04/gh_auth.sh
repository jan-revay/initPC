#!/bin/bash
# bash debug mode is off - as we don't want to leak the token
# BASE IMAGE: WSL Ubuntu 22.04
# REQUIRES A USER INPUT

read -sp 'Enter GitHub authentication token: ' TOKEN
readonly TOKEN

echo "${TOKEN}" | gh auth login --hostname GitHub.com --with-token
