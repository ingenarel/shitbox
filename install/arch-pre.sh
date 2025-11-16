#!/usr/bin/sh

[ -z "$DEVICE_NAME" ] && {
    echo "DEVICE_NAME empty"
    exit 1
}

[ -z "$PARTITION_NAME" ] && {
    echo "PARTITION_NAME empty"
    exit 1
}

[ -z "$BOOT_TYPE" ] && {
    "BOOT_TYPE empty"
    exit 1
}

mbr(){
    echo "Formatting /dev/$PARTITION_NAME to ext4"
    if mkfs.ext4 "/dev/$PARTITION_NAME"; then
        echo "Formatted /dev/$PARTITION_NAME to ext4"
    else
        exit 1
    fi
}

if [ -z "$ROOT_TYPE" ] || [ "$ROOT_TYPE" = "mbr" ]; then
    mbr || exit 1
fi

echo "Mounted /dev/$PARTITION_NAME to /mnt"\
    &&
mount "/dev/$PARTITION_NAME" /mnt\
    &&
echo "Mounted /dev/$PARTITION_NAME to /mnt"

pacstrapCommand="pacstrap -K /mnt\
    base\
    linux\
    grub\
    networkmanager\
    git\
    base-devel\
    man-db\
    openssh\
    dmidecode\
    sudo"

dmidecode -s system-manufacturer | grep -qEi 'qemu'\
    ||
pacstrapCommand="${pacstrapCommand}\linux-firmware intel-ucode"

echo "Running pacstrap"
eval "$pacstrapCommand" && echo "ran pacstrap" || exit 1

echo "Creating Swap"
mkswap --size 4G --file /mnt/swapFile && echo "Created swap" || exit 1

echo "Generating fstab"
if genfstab -U /mnt >> /mnt/etc/fstab; then
    echo "/swapFile none swap defaults" >> /mnt/etc/fstab
    echo "Generated fstab"
else
    exit 1
fi

archPostPath="/tmp/arch-post.sh"

arch-chroot /mnt\
    /usr/bin/bash\
    -c\
"\
    echo 'Creating user' && useradd --groups wheel --create-home ingenarel && echo 'Created user'

    echo 'Installing post-install script' &&\
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/arch-post.sh > $archPostPath &&\
    echo 'Installed post-chroot script'

    chown ingenarel $archPostPath && chmod +x $archPostPath && echo 'set up script permissions'

    setRootPassword(){
        echo 'enter the password for root'
        passwd || setRootPassword
    }
    setRootPassword

    setUserPassword(){
        echo 'enter the password for ingenarel'
        passwd ingenarel || setUserPassword
    }

    setUserPassword

    sed -iE\
        's/@includedir \/etc\/sudoers\.d/%wheel ALL=(ALL:ALL) ALL\n&/'\
        /etc/sudoers\
    &&
    echo 'set up Wheel group'

    echo 'Executing post-install script' && sudo -u ingenarel $archPostPath $1 mbr && echo 'Executed post-install script'
"
