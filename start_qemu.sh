#!/bin/bash
echo "Starting QEMU."
/home/wang/wang/runninglinuxkernel/qemu-patch-raspberry4/build/qemu-system-aarch64 \
-machine raspi4b1g \
-nographic \
-kernel benos.bin \
-S -s
