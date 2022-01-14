#!/usr/bin/env bash

set -e

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd ${script_dir}

rm -f opencore.img
truncate --size 200M opencore.img

cat<<-EOF | gdisk opencore.img
n
1


ef00
w
Y
EOF

sudo losetup --partscan /dev/loop0 opencore.img
sudo mkfs.vfat -n OpenCore /dev/loop0p1

mnt_dir=$(mktemp -d)
echo "mnt_dir: ${mnt_dir}"
sudo mount /dev/loop0p1 $mnt_dir

sudo rsync --verbose --recursive ./EFI/ $mnt_dir/EFI/
sudo cp ./config.plist $mnt_dir/EFI/OC/

sudo umount /dev/loop0p1

sudo losetup -D /dev/loop0
sudo rm -rf $mnt_dir

# qemu-img create -f qcow2 ./macintosh-hd.qcow2 240G
