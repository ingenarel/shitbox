#!/usr/bin/env bash

ifmounted() {
    local partition
    for partition in $(df | awk '/^\/dev\// {print $1}'); do
        [[ "$1" == "$partition" ]] && return 0
    done
    return 1
}

main(){
    local userUID="$(id -u $USER)"

    for partition in $(blkid | awk -F ':' '{print $1}'); do
        ifmounted "$partition"\
            ||
        mount\
            --mkdir\
            --onlyonce "$partition"\
            /mnt/$(echo "$partition" | awk -F '/' '{print $3}')\
            -o owner=$userUID,rw
    done
}

main
