#!/usr/bin/env bash

mbr(){
    mkfs.ext4 "/dev/$1"
}

[[ -z $3 || $3 == "mbr" ]] && mbr "$2"
mount "/dev/$2" /mnt

pacstrapCommand="pacstrap -K /mnt\
    base\
    linux\
    grub\
    networkmanager\
    git\
    base-devel\
    man-db\
    sudo"

dmidecode -s system-manufacturer | grep -qEi 'qemu' || pacstrapCommand="${pacstrapCommand}\linux-firmware intel-ucode"

genfstab -U /mnt >> /mnt/etc/fstab
archPostPath="/tmp/arch-post.sh"
arch-chroot /mnt "/usr/bin/bash"\
    "-c"\
    "useradd --groups wheel --create-home ingenarel;\
    [[ -d $archPostPath ]] || mkdir --parents $archPostPath;\
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/arch-post.sh > $archPostPath;\
    $archPostPath/install/arch-post.sh $1 mbr\
    "
