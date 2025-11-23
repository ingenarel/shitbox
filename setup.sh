#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"

[ -z "$DEVICE_NAME" ] && DEVICE_NAME="$1"
export DEVICE_NAME

[ -z "$PARTITION_NAME" ] && PARTITION_NAME="$2"
export PARTITION_NAME

[ -z "$BOOT_TYPE" ] && BOOT_TYPE="$3"
[ -z "$BOOT_TYPE" ] && BOOT_TYPE="$(blkid --match-tag PTTYPE --output value "$DEVICE_NAME")"
export BOOT_TYPE

[ -z "$HOST_NAME" ] && HOST_NAME="$4"
export HOST_NAME

showHelp(){
    echo "$scriptDir/setup.sh DEVICE_NAME PARTITION_NAME BOOT_TYPE HOST_NAME"
    echo "your storage device should be already parititioned beforehand, otherwise it's risky and stupid"
    echo "DEVICE_NAME, PARTITION_NAME, BOOT_TYPE, HOST_NAME can be an env var or passed in"
    echo ""
    echo "DEVICE_NAME:"
    echo "should be the storage device name that grub is gonna be installed in",
    echo "aka /dev/sda /dev/sdb"
    echo ""
    echo "PARTITION_NAME:"
    echo "your root partition name, is gonna be wiped"
    echo ""
    echo "BOOT_TYPE:"
    echo "script tries to automatically guess BOOT_TYPE by using blkid"
    echo ""
    echo "HOST_NAME:"
    echo "gentoo-main for main machine (TODO)"
    echo "gentoo-vm-tui for vm with tui config (TODO)"
    echo "gentoo-vm-gui for vm with gui config (TODO)"
    echo "gentoo-dist for a distfile maker (TODO)"
    echo "for arch, no custom HOST_NAME for now"
}

if [ "$BOOT_TYPE" != "mbr" ]; then
    echo "only mbr is currently supported at the time"
    showHelp
    exit 1
elif [ -z "$DEVICE_NAME" ]; then
    echo "DEVICE_NAME empty"
    showHelp
    exit 1
elif [ -z "$PARTITION_NAME" ]; then
    echo "PARTITION_NAME empty"
    showHelp
    exit 1
fi

if grep -qi 'arch' /etc/os-release && [ -d /run/archiso ]; then
    "$scriptDir/install/arch-pre.sh"
elif grep -qi 'gentoo' /etc/os-release && [ "$HOST" = "livecd" ]; then
    "$scriptDir/install/gentoo-pre.sh" "$DEVICE_NAME" "$PARTITION_NAME" "$BOOT_TYPE"
fi
