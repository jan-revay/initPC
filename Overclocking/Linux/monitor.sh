#!/bin/bash -x

NEEDLE='error\|exception\|fail\|fatal\|segfault\|corrupt\|abort\|warn\|unable\|bad\|wrong\|incorrect'

if grep -i "${NEEDLE}" bench.log bench_mini.log \
    output.log ./p95*/results.txt; then

    if ls error.log; then
        exit 0
    fi

    grep -i "${NEEDLE}" bench.log bench_mini.log output.log | tee error.log
    git add error.log
    git commit -m "Overclocking - automatic error report"
    git push
fi
