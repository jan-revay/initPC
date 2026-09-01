#!/bin/bash
. ../prelude.sh

# If on my work ThinkPad P1 Gen8
if lscpu | grep -F "Intel(R) Core(TM) Ultra 7 265H"; then
    if [[ -v ST0_BATTERY_MAX_CHARGE && "${ST0_BATTERY_MAX_CHARGE}" == "true" ]]; then
        echo 0 | sudo tee /sys/class/power_supply/BAT0/charge_control_start_threshold
        echo 100 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
    else
        echo 70 | sudo tee /sys/class/power_supply/BAT0/charge_control_start_threshold
        echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
    fi
fi
