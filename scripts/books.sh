#!/usr/bin/env bash

downloadBook(){
    [[ ! -d "$1" ]] && mkdir --parents "$1"
    [[ -z "$(
        find\
            -L\
            "$1"\
            -regextype posix-extended\
            -regex "$2"
    )" ]] &&
    wget\
        --no-clobber\
        --directory-prefix="$1"\
        "$3"
}

downloadBook\
    "$HOME/Documents/books/programming/C"\
    '.*C Programming - A Modern Approach.*\.pdf'\
    'https://dn790000.ca.archive.org/0/items/c-programming-a-modern-approach-2nd-ed-c-89-c-99-king-by/C%20Programming%20-%20A%20Modern%20Approach%20-%202nd_Ed%28C89%2C%20c99%29%20-%20King%20by%20.pdf'


downloadBook\
    "$HOME/Documents/books/programming/C"\
    '.*The C Answer Book.*\.pdf'\
    'https://dn790002.ca.archive.org/0/items/the-c-answer-book-second-edition-by-gimpel-tondo/The%20C%20Answer%20Book(Second%20Edition)%20-%20by%20Gimpel%2C%20Tondo.pdf'


downloadBook\
    "$HOME/Documents/books/programming/bash"\
    '.*bash\.pdf'\
    'https://www.gnu.org/software/bash/manual/bash.pdf'

downloadBook\
    "$HOME/Documents/books/programming/rust"\
    '.*the_rust_programming_language_dark\.pdf'\
    "$(
        curl https://api.github.com/repos/shirshak55/Rust-Book-In-PDF/releases/latest\
        |
        grep -oE "https://github.com/shirshak55/Rust-Book-In-PDF/releases/download/[a-zA-Z0-9.\-]+/the_rust_programming_language_dark.pdf"
    )"
