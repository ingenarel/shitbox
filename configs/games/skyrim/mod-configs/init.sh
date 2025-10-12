#!/usr/bin/env bash

command -v fd > /dev/null 2>&1 || {
    echo "fd not found"
    exit 1
}

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"
source "$scriptDir/../../../../utils/safelink.sh"
mo2Dir="$HOME/Games/MO2-skyrim"

findMO2(){
    local mo2ExePaths
    mo2ExePaths="$(fd --regex 'ModOrganizer.exe' "$HOME")"
    [[ -z "$mo2ExePaths" ]] && {
        df --local\
            -BG\
            --output='fstype,target'\
            |
        sed -E '/^(vfat|(dev)?tmpfs)\s+/d'\
            |
        tail -n+3\
            |
        awk '{print $2}'\
            |
        while IFS='' read -r mountPath; do
            echo "searching in $mountPath"
            mo2ExePaths="$(fd --regex 'ModOrganizer.exe' "$mountPath")"
            [[ -n "$mo2ExePaths" ]] && {
                echo "$mo2ExePaths" | while IFS='' read -r mo2ExePath; do
                    local rootDir
                    rootDir="$(dirname "$mo2ExePath")"
                    [[ -f "$rootDir/skyrim.ini" ]] && {
                        echo "mo2-skyrim found at $mo2ExePath"
                        echo "symlinking $rootDir dir to $mo2Dir"
                        safelink "$rootDir" "$mo2Dir"
                        exit 69
                    }
                done
                [[ "$?" == 69 ]] && exit 69
            }
        done
        [[ "$?" == 69 ]] && {
            return 0
            } || {
            echo "mo2-skyrim not found, exiting the script"
            exit 2
        }
    }
}

doConfigs(){
    echo "trying to setup the configs.."
    find "$scriptDir/overwrite" -type f | while IFS='' read -r line; do
        safelink "$line" "${line//$scriptDir/$mo2Dir}"
    done
}

if [[ ! -d "$mo2Dir" ]]; then
    echo "mo2-skyrim dir not found"
    findMO2 || exit
elif [[ ! -f "$mo2Dir/ModOrganizer.exe" ]]; then
    echo "mo2 executable not found"
    "renaming the old mo2 dir"
    mv "$mo2Dir" "${mo2Dir}-old-$(date +%s)"
    findMO2 || exit
fi

doConfigs
