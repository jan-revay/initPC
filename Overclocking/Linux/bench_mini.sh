#!/bin/bash -x

# save a copy of the output to a file
exec &>> >(tee bench_mini.log)

# phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
# pts/ramspeed pts/tinymembench

flatpak run com.geekbench.Geekbench6

phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
    pts/blender-4.3.0 pts/compress-7zip-1.11.0 pts/encode-flac-1.9.0 pts/mbw pts/stream \
    pts/ramspeed pts/tinymembench

pushd y-cruncher* || exit
for i in {1..3}; do
    echo "===== Iteration $i ====="
    ./y-cruncher bench 16G
done
popd || exit
