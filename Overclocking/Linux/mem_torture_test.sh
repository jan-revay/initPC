#!/bin/bash -x

# save a copy of the output to a file
exec &> >(tee output.log)

pushd p95* || exit
timeout --preserve-status 10h ./mprime -t \
    || timeout 2s speaker-test -t sine -f 1000
popd || exit

stressapptest -W -M "$(free -m | awk '/Mem:/ {print int($2 * 0.95)}')" -s 36000 \
    || timeout 2s speaker-test -t sine -f 1000

pushd y-cruncher* || exit
for i in {1..400}; do
    echo "===== Iteration $i ====="
    ./y-cruncher bench 16G || timeout 2s speaker-test -t sine -f 1000
done
popd || exit
