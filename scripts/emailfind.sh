#!/usr/bin/sh

[ -z "$CACHE_PATH" ] && CACHE_PATH="$HOME/.cache/emailfind"
[ -z "$DOMAIN_IGNORE" ] && DOMAIN_IGNORE='archlinux\.org'
[ -z "$TOR_SKIP" ] && TOR_SKIP='patreon\.com'

[ ! -d "$CACHE_PATH" ] && mkdir --parents "$CACHE_PATH"

if [ "$1" = true ]; then
    _USETOR=true
else
    _USETOR=false
fi

toTorOrNotToTor(){
    if [ "$_USETOR" = true ]; then
        echo "using tor to run " "$@" >&2
        torsocks "$@"
    elif [ "$_USETOR" = 'skipthisone' ]; then
        "$@"
        _USETOR=true
    else
        "$@"
    fi
}

domainName="$( echo "$2" | sed -n -E 's:\S+@(\S+\.)*([^.]+\.[^.]+)$:\2:p')"
# domainName="${2#*@}"
echo "$domainName" >&2

domainLink="https://$domainName/"
# echo "$domainLink" >&2

icoPath="$CACHE_PATH/$(echo "$domainName" | sha256sum | awk '{print $1}' )"
# echo "$icoPath" >&2

# ignore arch manually for now
[ ! -f "$icoPath" ] && echo "$domainName" | grep -v -q -E "$DOMAIN_IGNORE" && {
    echo "$domainName" | grep -q -E "$TOR_SKIP" && {
        _USETOR=false
        torChanged=true
    }
    while true; do
        redirURL="$(
            toTorOrNotToTor curl --silent\
                    --max-redirs=1\
                    --out-null\
                    --write-out '%{url_effective}'\
                    --follow\
                    "$domainLink" |
            grep -oE 'https?://[^/]+/'
        )"
        if ! toTorOrNotToTor wget --quiet "${domainLink}favicon.ico" -O "$icoPath"; then
            RFC5988IconLinks="$(toTorOrNotToTor curl --silent "$domainLink" | sed -n -E 's:.*<link\s+rel="icon"\s+type="image/\S+"\s+href="([^"]+)".+:\1:p' )"
            if [ -n "$RFC5988IconLinks" ]; then
                echo "$RFC5988IconLinks" | while IFS='' read -r line; do
                    toTorOrNotToTor wget --quiet "$domainLink$line" -O "$icoPath" && break
                done
            fi
            # toTorOrNotToTor wget --quiet "$(
            #     toTorOrNotToTor curl --silent --follow "$domainLink" | grep -o -E 'https://\S+\.ico'
            #     )" -O "$icoPath" ||
        fi
        file --mime-type "$icoPath" | grep -q -E '.*: image/\S+*$' && break || {
            if [ "$redirURL" != "$domainLink" ]; then
                domainLink="$redirURL"
            else
                break
            fi
        }
        "$torChanged" && {
            torChanged=false
            _USETOR=true
        }

    done
}

notify-send --icon "$icoPath" "$2" hi
