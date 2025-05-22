#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

mbr(){
    mkfs.ext4 "/dev/$1"
}

[[ -z $3 || $3 == "mbr" ]] && mbr "$2"
mount "/dev/$2" /mnt
pacstrap -K /mnt\
    base\
    linux\
    linux-firmware\
    grub\
    networkmanager\
    intel-ucode\
    linux-firmware\
    git\
    base-devel\
    man-db\
    sudo
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt "$scriptDir/arch-post.sh" "$1" "mbr"
