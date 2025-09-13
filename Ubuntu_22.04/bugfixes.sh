#!/bin/bash -x

sudo snap install chromium --revision=139.0.7258.138
sudo snap revert chromium
sudo snap refresh chromium --hold

# TODO
# run
# sudo snap refresh chromium --unhold
