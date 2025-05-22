#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

[[ -f /run/archiso ]] && "$scriptDir/install/arch-pre.sh" "$1" "$2" "$3"
"$scriptDir/configs/setup.sh"
