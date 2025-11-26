#!/usr/bin/sh

safelink(){
    parentPath="$(realpath --canonicalize-missing "$2/..")"

    [ -d "$parentPath" ]\
        ||
    {
        [ "$3" != 1 ]\
            &&
        mkdir --parents "$parentPath"\
            ||
        sudo mkdir --parents "$parentPath";
    }

    {
        [ -h "$2" ] && [ "$(realpath --canonicalize-missing "$2")" = "$1" ]
    } ||
    {
        [ "$3" != 1 ]\
            &&
        ln -sf "$1" "$2"\
            ||
        sudo ln -sf "$1" "$2"\
            &&
        echo "linked $1 to $2";
    }
}
