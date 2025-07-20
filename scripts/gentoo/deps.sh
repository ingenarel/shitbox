#!/usr/bin/env bash

[[ -z "$DEPS_SCRIPT_GENTOO_REPO" ]] && {
    echo "Please setup the DEPS_SCRIPT_GENTOO_REPO env"; exit
}

[[ -z "$DEPS_SCRIPT_GURU_REPO" ]] && {
    echo "Please setup the DEPS_SCRIPT_GURU_REPO env"; exit
}

[[ -z "$DEPS_SCRIPT_GITHUB_ENABLE" || "$DEPS_SCRIPT_GITHUB_ENABLE" == true ]] && {
    command -v gh > /dev/null 2>&1 || {
        echo "Please install github cli"; exit
    };
}

# shellcheck disable=SC2015
[[ "$2" == "guru"  ]] && depfilesRepo="$DEPS_SCRIPT_GURU_REPO" || {
    [[ "$2" == "gentoo" ]] && depfilesRepo="$DEPS_SCRIPT_GENTOO_REPO" || exit
}

export XZ_OPTS="-9e -T0"

package="$(echo "$1" | awk -F '/' '{print $NF}' | sed -nE 's/\/*(.+)\.([^.]+)/\1/p')"
ebuild "$1" manifest fetch unpack

packageFirst="$(echo "$package" | grep -oE '^[a-zA-Z0-9]+')"

for dir in "/var/tmp/portage/$( realpath "$1"\ | awk -F '/' '{print $(NF-2)}')/$package/work/"*; do
    [[
        "$(echo "$dir" | grep -oE "[^/]+$")" == "$packageFirst"*\
            &&
        "$(find "$dir" -maxdepth 0 -type d -empty 2>&1 | wc -l)" -lt 1
    ]]\
    &&
    {
        sourcePath="$dir"
        break
    }
done

cd "$sourcePath" || exit

depfileName="$package-deps.tar.xz"
if [[ "$3" == "go" ]]; then
    GOMODCACHE="$sourcePath/go-mod" go mod download -modcacherw -x || {
        error="$?"
        echo "go vendor creation failed"
        exit "$error"
    }
    COMPRESS_DIR="go-mod"
elif [[ "$3" == "rust" ]]; then
    cargo vendor || {
        error="$?"
        echo "cargo vendor creation failed"
        exit "$error"
    }
    COMPRESS_DIR="vendor"
else
    echo "invalid shit"
    exit
fi

tar --create --verbose --auto-compress --file "$depfileName" "$COMPRESS_DIR"
gh\
    release\
    create\
    "$depfileName"\
    "$depfileName"\
    --repo "$depfilesRepo"\
    --latest\
    --notes "$depfileName"\
    --title "$depfileName"
