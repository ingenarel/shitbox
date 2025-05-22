#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

[[ -d /run/archiso ]] && "$scriptDir/install/arch-pre.sh" "$1" "$2" "$3"
