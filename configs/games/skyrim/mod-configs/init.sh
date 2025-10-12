#!/usr/bin/env bash

LOOP_BREAK=69
MO2_SKYRIM_NOT_FOUND=2
WRONG_CASE=4

command -v rg >/dev/null 2>&1 && {
    [[ -z "$LIST_FILES" ]] && export LIST_FILES=RIPGREP
}

command -v fd >/dev/null 2>&1 && {
    [[ -z "$LIST_FILES" ]] && export LIST_FILES=FD
    [[ -z "$REGEX_FILE_SEARCH" ]] && export REGEX_FILE_SEARCH=FD
    } || { command -v find >dev/null 2>&1 && {
        export LIST_FILES=FIND
        export REGEX_FILE_SEARCH=FIND
    }
}

listFiles(){
    case "$LIST_FILES" in
        "RIPGREP")
            rg --files --color=never "$1"
            ;;
        "FD")
            fd --color=never --type=file . "$1"
            ;;
        "FIND")
            find "$1" -type f
            ;;
        *)
            exit $WRONG_CASE
            ;;
    esac
}

regexFileSearch(){
    case "$REGEX_FILE_SEARCH" in
        "FD")
            fd --color=never --regex "$2" "$1"
            ;;
        "FIND")
            find "$1" -regextype posix-extended -regex "$2"
            ;;
        *)
            exit $WRONG_CASE
            ;;
    esac
}

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"
source "$scriptDir/../../../../utils/safelink.sh"
mo2Dir="$HOME/Games/MO2-skyrim"

findMO2(){
    local mo2ExePaths
    mo2ExePaths="$(regexFileSearch "$HOME" 'ModOrganizer.exe')"
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
            mo2ExePaths="$(regexFileSearch "$mountPath" 'ModOrganizer.exe')"
            [[ -n "$mo2ExePaths" ]] && {
                echo "$mo2ExePaths" | while IFS='' read -r mo2ExePath; do
                    local rootDir
                    rootDir="$(dirname "$mo2ExePath")"
                    [[ -f "$rootDir/skyrim.ini" ]] && {
                        echo "mo2-skyrim found at $mo2ExePath"
                        echo "symlinking $rootDir dir to $mo2Dir"
                        safelink "$rootDir" "$mo2Dir"
                        exit $LOOP_BREAK
                    }
                done
                [[ "$?" == "$LOOP_BREAK" ]] && exit $LOOP_BREAK
            }
        done
        [[ "$?" == "$LOOP_BREAK" ]] && {
            return 0
            } || {
            echo "mo2-skyrim not found, exiting the script"
            exit $MO2_SKYRIM_NOT_FOUND
        }
    }
}

doConfigs(){
    echo "trying to setup the configs.."
    listFiles "$scriptDir/overwrite" | while IFS='' read -r line; do
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
