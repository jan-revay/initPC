#!/bin/bash -x

# save a copy of the output to a file
exec &>> >(tee bench_mini.log)

phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
    pts/ramspeed pts/tinymembench

flatpak run com.geekbench.Geekbench6

pushd y-cruncher* || exit
for i in {1..3}; do
    echo "===== Iteration $i ====="
    ./y-cruncher bench 16G || timeout 2s speaker-test -t sine -f 1000
done
popd || exit
