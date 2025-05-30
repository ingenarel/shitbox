#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

for shit in $scriptDir/plugins/*; do
    git -C "$shit" pull origin master || git -C "$shit" pull origin main
done

git -C "$scriptDir" add plugins
git -C "$scriptDir" commit -m "(auto): update yazi plugins"
