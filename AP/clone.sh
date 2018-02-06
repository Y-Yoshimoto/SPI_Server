#!/bin/sh
# ./clone.sh OriginalName　CopyName
echo "Original:" $1
echo "Copy to :" $2

# Confirm the number of arguments.
if [ $# -ne 2 ]; then
    echo "Two arguments are required." 1>&2
    exit 1
fi

# Yes or no
echo "Do you want to clone with this setting [y/n]?"
read ANSWER
case $ANSWER in
    "y" | "yes") echo "yes";;
    * ) echo "no";exit 1;;
esac

# Clone of KVM virtual machine.
virt-clone  \
--original $1 \
--name $2 \
--file "$HOME/SPIArea/KVM_images/"$2".qcow2"

echo "End script"
