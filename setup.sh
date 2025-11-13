#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

if grep -qi 'arch' /etc/os-release && [[ -d /run/archiso ]]; then
    "$scriptDir/install/arch-pre.sh" "$1" "$2" "$3"
elif grep -qi 'gentoo' /etc/os-release && [[ "$HOSTNAME" == "livecd" ]]; then
    "$scriptDir/install/gentoo-pre.sh" "$1" "$2" "$3"
fi
