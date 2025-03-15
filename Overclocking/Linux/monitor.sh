#!/bin/bash -x

if grep -i error ./output.log; then
    grep -i error ./output.log | tee error.log
    git add error.log
    git commit -m "Overclocking - automatic error report"
    git push
fi
