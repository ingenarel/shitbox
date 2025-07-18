#!/usr/bin/env bash

CParentPath="$HOME/Documents/books/programming/C"
[[ ! -d "$CParentPath" ]] && mkdir --parents "$CParentPath"
ls -f "$CParentPath/C Programming - A Modern Approach"*".pdf"\
    ||
wget\
    --no-use-server-timestamps\
    --directory-prefix="$CParentPath"\
    "https://dn790000.ca.archive.org/0/items/c-programming-a-modern-approach-2nd-ed-c-89-c-99-king-by/C%20Programming%20-%20A%20Modern%20Approach%20-%202nd_Ed%28C89%2C%20c99%29%20-%20King%20by%20.pdf"

BashReferenceManualParentPath="$HOME/Documents/books/programming/bash"
[[ ! -d "$BashReferenceManualParentPath" ]] && mkdir --parents "$BashReferenceManualParentPath"
ls -f "$BashReferenceManualParentPath/bash.pdf"\
    ||
wget\
    --no-use-server-timestamps\
    --directory-prefix="$CParentPath"\
    "https://www.gnu.org/software/bash/manual/bash.pdf"

RustBookParentPath="$HOME/Documents/books/programming/rust"
[[ -d "$RustBookParentPath" ]] || mkdir --parents "$RustBookParentPath"
ls -f "$RustBookParentPath/the_rust_programming_language_dark.pdf"\
    ||
wget\
    --no-use-server-timestamps\
    --directory-prefix="$RustBookParentPath"\
    "$(
        curl https://api.github.com/repos/shirshak55/Rust-Book-In-PDF/releases/latest\
        |
        grep -oE "https://github.com/shirshak55/Rust-Book-In-PDF/releases/download/[a-zA-Z0-9.\-]+/the_rust_programming_language_dark.pdf"
)"
