#!/bin/bash
. ../prelude.sh

# If on my work ThinkPad P1 Gen8
if lscpu | grep -F "Intel(R) Core(TM) Ultra 7 265H"; then
    echo 70 | sudo tee /sys/class/power_supply/BAT0/charge_control_start_threshold
    echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
fi
