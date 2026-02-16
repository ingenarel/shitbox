#!/usr/bin/sh

fileData="$( cat /dev/stdin )"

tmpDir="$HOME/.cache/aerc/custom-scripts/files/"
[ ! -d "$tmpDir" ] && mkdir --parents "$tmpDir"

tmpFile="$tmpDir/$( printf '%s' "$fileData" | sha512sum | awk '{ print $1 }' )"

printf '%s' "$fileData" > "$tmpFile"

execCommand=""
browserName=""

[ -n "$SWAYSOCK" ] && {
    execCommand='swaymsg exec'
}

for name in librewolf librewolf-bin zen-twilight zen-twilight-bin; do
    command -v "$name" && browserName="$name" && break
done

[ -n "$browserName" ] && [ -n "$execCommand" ] && {

    $execCommand $browserName "$tmpFile"

}
