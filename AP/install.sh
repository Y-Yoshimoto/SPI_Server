#!/bin/sh
# --name, --diskを編集
#qemu-img create -f qcow2 server.qcow2 5G
virt-install \
--name APServer_1 \
--ram=640 \
--disk path='~/SPIArea/KVM_images/server.qcow2',size=10,format=qcow2 \
--vcpus 1 \
--os-type linux \
--os-variant rhel7 \
--network network=default \
--graphics none \
--console pty,target_type=serial \
--location '~/SPIArea/OS_iso/CentOS-7-x86_64-Minimal-1708.iso' \
--extra-args 'console=ttyS0,115200n8 serial'
