#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"

[ -z "$DEVICE_NAME" ] && export DEVICE_NAME="$1"
[ -z "$PARTITION_NAME" ] && export PARTITION_NAME="$2"
[ -z "$BOOT_TYPE" ] && export BOOT_TYPE="$3"
[ -z "$HOST_NAME" ] && export HOST_NAME="$4"

showHelp(){
    echo "$scriptDir/setup.sh DEVICE_NAME PARTITION_NAME BOOT_TYPE"
    echo "DEVICE_NAME, PARTITION_NAME, BOOT_TYPE can be an env var or passed in"
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
