#!/usr/bin/env bash

depfilesRepo=ingenarel/guru-depfiles
package="$(echo "$1" | awk -F '/' '{print $NF}' | sed -nE 's/\/*(.+)\.([^.]+)/\1/p')"
ebuild "$1" manifest fetch unpack
sourcePath="/var/tmp/portage/$(realpath "$1" | awk -F '/' '{print $(NF-2)}')/$package/work/$package"
cd "$sourcePath" || exit
GOMODCACHE="$sourcePath/go-mod" go mod download -modcacherw -x
depfileName="$package-deps.tar.xz"
tar --create --auto-compress --file "$depfileName" go-mod
gh release create "$depfileName" --repo "$depfilesRepo"
gh release upload "$depfileName" "$depfileName" --repo "$depfilesRepo"
