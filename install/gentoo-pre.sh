#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

mbr(){
    echo "Formatting /dev/$1 to ext4" && mkfs.ext4 "/dev/$1" && echo "Formatted /dev/$1 to ext4"
}

[[ -z $3 || $3 == "mbr" ]] && mbr "$2"

echo "Mounted /dev/$2 to /mnt/gentoo" && mount "/dev/$2" /mnt/gentoo && echo "Mounted /dev/$2 to /mnt/gentoo"

wget --directory-prefix=/mnt/gentoo \
    "$(
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
dmidecode -s system-manufacturer | grep -qEi 'qemu' &&
(
    cp "$scriptDir/../configs/programs/portage/tui-vm-make.conf" "/mnt/gentoo/etc/portage/make.conf" &&
    cp -r "$scriptDir/../configs/programs/portage/package.use" "/mnt/gentoo/etc/portage/package.use"
)

cp --dereference /etc/resolv.conf /mnt/gentoo/etc/

emergeCommand="emerge\
    grub\
    networkmanager\
    dev-vcs/git\
    installkernel\
    dracut\
    man-db\
    gentoo-kernel-bin\
    eselect-repository\
    gentoolkit\
    sudo"

dmidecode -s system-manufacturer | grep -qEi 'qemu' || emergeCommand="${emergeCommand} linux-firmware intel-microcode"
echo "Creating Swap" && mkswap --size 4G --file /mnt/gentoo/swapFile && echo "Created swap"

gentooPostPath="/tmp/gentoo-post.sh"
arch-chroot /mnt/gentoo "/usr/bin/bash"\
    "-c"\
    "\
    echo 'doing webrsync' && emerge-webrsync && echo 'finished webrsync'

    echo 'syncing emerge' && emerge --sync && echo 'synced emerge'

    echo 'setting cpu flags' &&
    emerge --ask n --oneshot app-portage/cpuid2cpuflags &&
    echo \"*/* \$(cpuid2cpuflags)\" > /etc/portage/package.use/00cpu-flags

    emerge --ask --verbose --update --deep --newuse @world

    emerge --ask --depclean

    ln -sf ../usr/share/zoneinfo/Asia/Dhaka /etc/localtime

    echo 'generating locales' &&
    echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen &&
    locale-gen &&
    echo 'LANG=en_US.UTF-8' > /etc/locale.conf &&
    echo 'Generated locales'

    env-update && source /etc/profile

    $emergeCommand

    echo 'Creating user' && useradd --groups wheel,portage --create-home ingenarel && echo 'Created user'

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

    sed -E 's/@includedir \/etc\/sudoers\.d/%wheel ALL=(ALL:ALL) ALL\n&/' /etc/sudoers && echo 'set up Wheel group'

    echo 'Installing post-install script' &&
    curl https://raw.githubusercontent.com/ingenarel/shitbox/refs/heads/master/install/gentoo-post.sh > $gentooPostPath &&
    echo 'Installed post-chroot script' &&
    chown ingenarel $gentooPostPath && chmod +x $gentooPostPath && echo 'set up script permissions'
    echo 'Executing post-install script' && sudo -u ingenarel $gentooPostPath $1 mbr && echo 'Executed post-install script'
"
