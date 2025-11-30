#!/usr/bin/sh

find "$(realpath "$1")" -maxdepth 2 -type d -regextype posix-extended -regex '.*/.+/.+' | while IFS='' read -r packageName; do
    remoteLine="$(grep '<remote-id type="github">' "$packageName/metadata.xml" 2>/dev/null)"
    [ -n "$remoteLine" ] && {
        properRemote="$(
            echo "$remoteLine"\
                |
            sed -E 's/^.*<remote-id\s*type="github">\s*(\S+\/\S+)\s*<\/remote-id>.*$/\1/' 2>/dev/null\
                |
            head -n1
        )"
        find "$packageName" -maxdepth 1 -type f -regex '.*\.ebuild' | sort -r | while IFS='' read -r ebuildName; do
            echo "$ebuildName" | grep -q '9999' && {
                continue
            }
            actualPackage="$(dirname "$ebuildName" | grep -oE '[^/]+$')"
            actualEbuild="$(basename -s ".ebuild" "$ebuildName")"
            actualVersion="$(echo "$actualEbuild" | sed -E "s/$actualPackage-([^_\-]+).*/\1/" )"
            latestVersion="$(
                gh release --repo "$properRemote" list --limit 2 --order desc --json tagName --jq '.[].tagName'\
                    |
                sed '/nightly/d'\
                    |
                head -n1\
                    |
                sed -E 's/v?(.+)/\1/'
            )"
            {
                [ -n "$latestVersion" ]\
                    &&
                ! printf '%s\n%s\n' "$latestVersion" "$actualVersion"\
                    |
                sort --check=quiet --version-sort
                } && {
                echo "$packageName:"
                echo "actualVersion: '$actualVersion' != latestVersion: '$latestVersion'"
                echo "https://github.com/$properRemote/tags"
                echo ''
            }
            break
        done
    }
done
