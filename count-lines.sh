#!/usr/bin/env bash

lines=0
for file in $(git ls-files); do
    file --mime-type "$file" | grep -qE ".+ text/.+" && {
        lines="$(( "$lines" + "$( wc -l "$file" | grep -oE "^[0-9]+")" ))"
    }
done
echo "$lines"
