#!/bin/bash

/usr/bin/notify-send --transient --urgency critical "Shutting down in 1 min" "$1"
/sbin/shutdown
