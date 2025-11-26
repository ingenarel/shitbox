#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"

. "$scriptDir/../scripts/die.sh"

[ -z "$DEVICE_NAME" ] && {
    die "DEVICE_NAME empty, are you running the root script?"
}

[ -z "$PARTITION_NAME" ] && {
    die "PARTITION_NAME empty, are you running the root script?"
}

[ -z "$BOOT_TYPE" ] && {
    die "BOOT_TYPE empty, are you running the root script?"
}

[ -z "$HOST_NAME" ] && {
    die "HOST_NAME empty, are you running the root script?"
}

dos(){
    echo "Formatting /dev/$PARTITION_NAME to ext4"
    if mkfs.ext4 "/dev/$PARTITION_NAME"; then
        echo "Formatted /dev/$PARTITION_NAME to ext4"
    else
        die "formatting /dev/$PARTITION_NAME failed"
    fi
}

# if function because i'll do uefi later
if [ -z "$BOOT_TYPE" ] || [ "$BOOT_TYPE" = "dos" ]; then
    dos
fi

mount "/dev/$PARTITION_NAME" /mnt/gentoo\
    &&
echo "Mounted /dev/$PARTITION_NAME to /mnt/gentoo"

wget --directory-prefix=/mnt/gentoo "$(
    curl https://www.gentoo.org/downloads/\
        |
    grep -oE 'https://\S++stage3-amd64-systemd-\S+.tar.xz'\
        |
    head -n1
)"

sync

sleep 1

sync

tar xpvf /mnt/gentoo/stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner -C /mnt/gentoo

rm /mnt/gentoo/stage3-*.tar.xz

if [ "$HOST_NAME" = "gentoo-vm-tui" ]; then
    cp -Tf "$scriptDir/../configs/programs/portage/tui-vm/make.conf"\
        "/mnt/gentoo/etc/portage/make.conf" ||
    die "cping make failed"

    cp --parents -rTf "$scriptDir/../configs/programs/portage/tui-vm/package.use"\
        "/mnt/gentoo/etc/portage/package.use" ||
    die "cping package.use failed"

    cp --parents -rTf "$scriptDir/../configs/programs/portage/tui-vm/package.accept_keywords"\
        "/mnt/gentoo/etc/portage/package.accept_keywords" ||
    die "cping package.accept_keywords failed"
fi

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ || {
    die "cping resolve.conf failed"
}

emergeCommand="emerge --ask n\
    sys-boot/grub\
    net-misc/networkmanager\
    dev-vcs/git\
    sys-kernel/installkernel\
    sys-kernel/dracut\
    sys-apps/man-db\
    sys-kernel/gentoo-kernel-bin\
    app-eselect/eselect-repository\
    app-portage/gentoolkit\
    net-misc/curl\
    app-admin/sudo\
    sys-apps/dmidecode"

dmidecode -s system-manufacturer | grep -qEi 'qemu' || emergeCommand="${emergeCommand} sys-kernel/linux-firmware"
echo "Creating Swap" && mkswap --size 4G --file /mnt/gentoo/swapFile && echo "Created swap"

gentooPostPath="/tmp/gentoo-post.sh"
arch-chroot /mnt/gentoo "/usr/bin/sh" "-c" "\
    DEVICE_NAME='$DEVICE_NAME'
    export DEVICE_NAME

    PARTITION_NAME='$PARTITION_NAME'
    export PARTITION_NAME

    BOOT_TYPE='$BOOT_TYPE'
    export BOOT_TYPE

    HOST_NAME='$HOST_NAME'
    export HOST_NAME

    {
        emerge-webrsync && echo 'finished webrsync'
    } || {
        echo 'emerge-webrsync failed'
        exit 1
    }

    emerge --sync && echo 'synced emerge'

    {
        emerge --ask n --oneshot app-portage/cpuid2cpuflags &&
        echo \"*/* \$(cpuid2cpuflags)\" > /etc/portage/package.use/00cpu-flags
    } || {
        echo 'SETTING CPU FLAGS FAILED'
    }

    emerge --ask --verbose --update --deep --newuse @world

    emerge --ask --depclean

    ln -sf ../usr/share/zoneinfo/Asia/Dhaka /etc/localtime

    {
        echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen &&
        locale-gen &&
        echo 'LANG=en_US.UTF-8' > /etc/locale.conf &&
        echo 'Generated locales'
    } || {
        echo 'LOCAL GENERATION FAILED'
    }

    env-update && source /etc/profile

    $emergeCommand

    useradd --groups wheel,portage --create-home ingenarel && echo 'Created user'

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

    echo 'Installing post-install script'
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/gentoo-post.sh > $gentooPostPath &&
    echo 'Installed post-chroot script' &&
    chown ingenarel $gentooPostPath &&
    chmod +x $gentooPostPath &&
    echo 'set up script permissions'

    echo 'Executing post-install script'
    sudo -u ingenarel\
        --preserve-env=DEVICE_NAME,PARTITION_NAME,BOOT_TYPE,HOST_NAME\
        $gentooPostPath &&
    echo 'Executed post-install script'
"
