#!/bin/bash -x

# save a copy of the output to a file
exec &> >(tee output.log)

inxi -Fxxxz
phoronix-test-suite batch-run pts/ramspeed pts/tinymembench
memtester 10G 10
# phoronix-test-suite batch-install pts/ramspeed

# phoronix-test-suite batch-setup
# we grep for / to filter out coulmn headers
# mapfile -t RECOMMENDED_TESTS < <(phoronix-test-suite list-recommended-tests | awk '/\// {print $1}')
# AVAILABLE_TESTS=$(phoronix-test-suite list-available-tests | awk '{print $1}' | tail -n +5)
# phoronix-test-suite batch-install ${AVAILABLE_TESTS}
# phoronix-test-suite batch-install "${RECOMMENDED_TESTS[@]}"
# phoronix-test-suite batch-run $(phoronix-test-suite list-recommended-tests | awk '/\// {print $1}')
# phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
#    git/x265-1.1.0 pts/amg-1.1.0 pts/blake2-1.2.2 pts/blender-4.3.0 pts/pgbench-1.15.0 pts/perf-bench-1.1.0 \
#    pts/m-queens-1.1.0 pts/glibc-bench-1.9.0 pts/encode-flac-1.9.0 pts/compress-7zip-1.11.0 pts/byte-1.3.0 \
#    pts/blender-4.3.0

flatpak run com.geekbench.Geekbench6

pushd p95* || exit
# Results are in ./results.txt file
timeout --preserve-status 28h ./mprime -t \
    || timeout 2s speaker-test -t sine -f 1000

popd || exit

if grep -i error output.log; then
    timeout 2s speaker-test -t sine -f 1000
fi

stress-ng --tz --metrics-brief --matrix 0 -t 2h
stress-ng --vm 96 --vm-bytes 95% --vm-method all --tz --metrics-brief --timeout 1h
stress-ng --memrate 0 --metrics-brief --timeout 30m
stress-ng --cache 0 --cache-fence --metrics-brief --timeout 30m
stress-ng --matrix 0 --vm 96 --vm-bytes 95% --cache 0 --cache-fence --tz --metrics-brief --timeout 1h

stressapptest -W -M "$(free -m | awk '/Mem:/ {print int($2 * 0.95)}')" -s 65000 \
    || timeout 2s speaker-test -t sine -f 1000

pushd y-cruncher* || exit
for i in {1..600}; do
    echo "===== Iteration $i ====="
    ./y-cruncher bench 16G || timeout 2s speaker-test -t sine -f 1000
done
popd || exit

./burnintest/bit_cmd_line_x64

phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
    pts/blender-4.3.0 pts/compress-7zip-1.11.0 pts/encode-flac-1.9.0

