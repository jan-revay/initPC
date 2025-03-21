#!/bin/bash -x

# save a copy of the output to a file
exec &>> >(tee bench.log)

phoronix-test-suite batch-run system/compress-7zip-1.0.0 pts/build-linux-kernel-1.16.0 pts/build-php-1.7.0 \
    pts/blender-4.3.0 pts/compress-7zip-1.11.0 pts/encode-flac-1.9.0 pts/mbw pts/stream \
    pts/hpcc-1.2.8 pts/hpl-1.0.0 pts/nero2d-1.1.0 pts/nwchem-1.2.0 pts/open-porous-media-1.3.1 \
    pts/opm-git-1.3.51 pts/qe-1.3.1 pts/qmcpack-1.8.0 pts/wrf-1.0.1 pts/ramspeed pts/tinymembench

flatpak run com.geekbench.Geekbench6

pushd y-cruncher* || exit
for i in {1..3}; do
    echo "===== Iteration $i ====="
    ./y-cruncher bench 16G || timeout 2s speaker-test -t sine -f 1000
done
popd || exit
