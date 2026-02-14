#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"

. "$scriptDir/../../utils/safelink.sh"

UNLOCKED_DIR="$scriptDir/secrets/unlocked"
LOCKED_DIR="$scriptDir/secrets/locked"

export UNLOCKED_DIR
export LOCKED_DIR

scriptHelp(){
    echo "./encrypt-decrypt-files.sh ENCRYPTED_ARCHIVE_PASSWORD ARCHIVE_PASSWORD FILE_PASSWORD (encrypt|decrypt) configure?"
}

gpgEncrypt(){
    gpg\
        --symmetric\
        --batch\
        --cipher-algo AES256\
        --digest-algo SHA512\
        --compress-algo ZLIB\
        --s2k-mode 3\
        --s2k-digest-algo SHA512\
        --s2k-cipher-algo AES256\
        --s2k-count 65011712\
        --passphrase "$3"\
        --output "$2"\
        "$1"
}

gpgDecrypt(){
    gpg\
        --decrypt\
        --batch\
        --yes\
        --passphrase "$3"\
        --output "$2"\
        "$1"
}

encryptSingleFiles(){
    find "$UNLOCKED_DIR" -type f | while IFS='' read -r line; do
        filePathInsideUnlocked="${line#"$UNLOCKED_DIR"}"
        rootDir="$(dirname "${LOCKED_DIR}${filePathInsideUnlocked}")"
        [ ! -d "$rootDir" ] && mkdir --parents "$rootDir"
        outputFile="${LOCKED_DIR}/${filePathInsideUnlocked}.gpg"
        [ -f "$outputFile" ] && rm "$outputFile"
        gpgEncrypt "$line" "$outputFile" "$1"
    done
}

decryptSingleFiles(){
    find "$LOCKED_DIR" -type f | while IFS='' read -r line; do
        filePathInsidelocked="${line#"$LOCKED_DIR"}"
        rootDir="$(dirname "${UNLOCKED_DIR}${filePathInsidelocked}")"
        [ ! -d "$rootDir" ] && mkdir --parents "$rootDir"
        outputFile="${UNLOCKED_DIR}${filePathInsidelocked%.gpg}"
        [ -f "$outputFile" ] && rm "$outputFile"
        gpgDecrypt "$line" "$outputFile" "$1"
    done
}

recusiveMimeTypeCommand(){
    find "$1"\
        -type f\
        -exec file --no-pad --mime-type {} +\
        |
    awk -F ':' "BEGIN { ORS = \"\\0\" }; { if ( \$2 ~ \"$2\" ) print \$1 }"\
        |
    xargs --null $3
}

ENCRYPTED_ARCHIVE="$scriptDir/secrets.zpaq.gpg"

if [ "$4" = "encrypt" ]; then
    encryptSingleFiles "$3"
    zpaq add "$scriptDir/secrets.zpaq" "$(
        realpath --relative-to "$scriptDir" "$LOCKED_DIR"
    )" -key "$2" -m5
    [ -f "$ENCRYPTED_ARCHIVE" ] && rm "$ENCRYPTED_ARCHIVE"
    gpgEncrypt "$scriptDir/secrets.zpaq" "$ENCRYPTED_ARCHIVE" "$1"
elif [ "$4" = "decrypt" ]; then
    gpgDecrypt "$ENCRYPTED_ARCHIVE" "$scriptDir/secrets.zpaq" "$1"
    zpaq extract "$scriptDir/secrets.zpaq" -key "$2" -force
    decryptSingleFiles "$3"
    recusiveMimeTypeCommand "$scriptDir/secrets/unlocked" "application/(x-pem-file|pgp-keys)" "chmod 600"
    if [ "$5" = "configure" ]; then
        safelink "$scriptDir/../programs/ssh/config" "$HOME/.ssh/config"
        recusiveMimeTypeCommand "$scriptDir/secrets/unlocked/gpg" "application/pgp-keys" "gpg --import"
        gpg --list-keys --with-colons 'ingenarelitems@gmail.com' | sed -n -E 's/^fpr:+([^:]+):+/\1:6:/p'\
            |
        gpg --import-ownertrust
        chown -R "$(whoami)" "$HOME/.gnupg"
        find "$HOME/.gnupg" -type f -exec chmod 600 {} \;
        find "$HOME/.gnupg" -type d -exec chmod 700 {} \;
    fi
else
    scriptHelp
fi
