#!/bin/bash

# TODO fix the notify-send https://www.perplexity.ai/search/notify-send-does-not-work-when-iCt5Y1qiSW.ZRYifyqzTug

/usr/bin/notify-send --transient --urgency critical "Shutting down in 1 min" "$1"
/sbin/shutdown
