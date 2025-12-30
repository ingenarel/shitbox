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
command -v librewolf && browserName='librewolf' || {
    command -v zen-twilight && browserName='zen-twilight'
}

[ -n "$browserName" ] && [ -n "$execCommand" ] && {

    $execCommand $browserName "$tmpFile"

}
