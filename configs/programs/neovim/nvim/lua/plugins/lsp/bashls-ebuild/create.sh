#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"
ebuildHTML="$scriptDir/ebuild.5.html"

endingTagSearch=false
{
    [ ! -f "$ebuildHTML" ] || [ "$1" = true ]
} &&
curl --silent 'https://dev.gentoo.org/~zmedico/portage/doc/man/ebuild.5.html' > "$scriptDir/ebuildHTML"

while IFS='' read -r line; do
    $endingTagSearch && {
        case "$line" in
            '<H3>'*)
                exit
                ;;
            *)
                echo "$line"
                ;;
        esac
        } || {
        [ "$line" = '<H3>Variables Used In Ebuilds</H3>' ] && {
            echo "$line"
            endingTagSearch=true
        }
    }
done < "$ebuildHTML" |
tail -n +4 |
sed -nE 's/^<DT><B>([^<]+)<.*/export \1/p' > "$scriptDir/ebuild-vars.sh"
