#!/usr/bin/env bash

CParentPath="$HOME/Documents/books/programming/C"
[[ ! -d "$CParentPath" ]] && mkdir --parents "$CParentPath"
ls -f "$CParentPath/C Programming - A Modern Approach"*".pdf"\
    ||
wget\
    --no-use-server-timestamps\
    --directory-prefix="$CParentPath"\
    "https://dn790000.ca.archive.org/0/items/c-programming-a-modern-approach-2nd-ed-c-89-c-99-king-by/C%20Programming%20-%20A%20Modern%20Approach%20-%202nd_Ed%28C89%2C%20c99%29%20-%20King%20by%20.pdf"
