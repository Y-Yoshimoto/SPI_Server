#!/bin/sh
# --name, --disk, --locationを編集
# sudo(root権限)で実行する事
qemu-img create -f qcow2 "$HOME/SPIArea/KVM_images/APServer1.qcow2" 5G
virt-install \
--name APServer1 \
--ram=1024 \
--disk path="$HOME/SPIArea/KVM_images/APServer_1.qcow2",size=5,format=qcow2 \
--vcpus 1 \
--arch x86_64 \
--os-type linux \
--os-variant rhel7 \
--network network=default \
--graphics none \
--console pty,target_type=serial \
--location "$HOME/SPIArea/OS_iso/CentOS-7-x86_64-Minimal-1708.iso" \
--initrd-inject="$HOME/SPIArea/SPI_Server/AP/centos7.ks.cfg" \
--extra-args "ks=file:/centos7.ks.cfg console=ttyS0"
