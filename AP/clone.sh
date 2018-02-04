#!/bin/sh
virt-clone  \
--original Server1 \
--name Server2 \
--file '~/SPIArea/KVM_images/server.qcow2'
