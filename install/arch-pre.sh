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
archPostPath="/tmp/arch-post.sh"
arch-chroot /mnt "/usr/bin/bash"\
    "-c"\
    "useradd --groups wheel --create-home ingenarel;\
    [[ -d $archPostPath ]] || mkdir --parents $archPostPath;\
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/arch-post.sh > $archPostPath;\
    $archPostPath/install/arch-post.sh $1 mbr\
    "
