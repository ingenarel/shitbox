#!/usr/bin/env bash

mbr(){
    echo "Formatting /dev/$1 to ext4" && mkfs.ext4 "/dev/$1" && echo "Formatted /dev/$1 to ext4"
}

[[ -z $3 || $3 == "mbr" ]] && mbr "$2"

echo "Mounted /dev/$2 to /mnt" && mount "/dev/$2" /mnt && echo "Mounted /dev/$2 to /mnt"

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
echo "Running pacstrap" && eval "$pacstrapCommand" && echo "ran pacstrap"

echo "Creating Swap" && mkswap --size 4G --file /swapFile && echo "Created swap"

echo "Generating fstab" && genfstab -U /mnt >> /mnt/etc/fstab && echo "/swapfile none swap defaults" >> /mnt/etc/fstab && echo "Generated fstab"

archPostPath="/tmp/arch-post.sh"
arch-chroot /mnt "/usr/bin/bash"\
    "-c"\
    "\
    echo 'Creating user' && useradd --groups wheel --create-home ingenarel && echo 'Created user';\

    echo 'Installing post-install script' &&\
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/arch-post.sh > $archPostPath &&\
    echo 'Installed post-chroot script';\

    echo 'Making script an executable' && chmod u+x $archPostPath && echo 'Made script an executable';\

    echo 'Executing post-install script' && $archPostPath $1 mbr && echo 'Executed post-install script';\
    "
