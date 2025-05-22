#!/usr/bin/env bash

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
shitboxDir="/home/ingenarel/.config/shitbox"
arch-chroot /mnt "/usr/bin/bash"\
    "-c"\
    "[[ -d $shitboxDir ]] || mkdir --parents $shitboxDir;\
    git clone https://github.com/ingenarel/shitbox $shitboxDir;\
    $shitboxDir/install/arch-post.sh\
    "
