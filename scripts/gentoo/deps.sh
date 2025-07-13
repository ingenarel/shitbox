#!/usr/bin/env bash

[[ "$2" == "guru"  ]] && depfilesRepo=ingenarel/guru-depfiles || {
    [[ "$2" == "gentoo" ]] && depfilesRepo=ingenarel/gentoo || exit
}

package="$(echo "$1" | awk -F '/' '{print $NF}' | sed -nE 's/\/*(.+)\.([^.]+)/\1/p')"
ebuild "$1" manifest fetch unpack
sourcePath="/var/tmp/portage/$(realpath "$1" | awk -F '/' '{print $(NF-2)}')/$package/work/$package"
cd "$sourcePath" || exit

depfileName="$package-deps.tar.xz"
if [[ "$3" == "go" ]]; then
    GOMODCACHE="$sourcePath/go-mod" go mod download -modcacherw -x || {
        error="$?"
        echo "go vendor creation failed"
        exit "$error"
    }
    tar --create --auto-compress --file "$depfileName" go-mod
elif [[ "$3" == "rust" ]]; then
    cargo vendor || {
        error="$?"
        echo "cargo vendor creation failed"
        exit "$error"
    }
    tar --create --auto-compress --file "$depfileName" vendor
else
    echo "invalid shit"
fi
gh release create "$depfileName" --repo "$depfilesRepo"
gh release upload "$depfileName" "$depfileName" --repo "$depfilesRepo"
