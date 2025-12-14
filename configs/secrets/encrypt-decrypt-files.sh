#!/usr/bin/sh

scriptDir="$(realpath --canonicalize-missing "$0/..")"

UNLOCKED_DIR="$scriptDir/secrets/unlocked"
LOCKED_DIR="$scriptDir/secrets/locked"

export UNLOCKED_DIR
export LOCKED_DIR

scriptHelp(){
    echo "./encrypt-decrypt-files.sh ENCRYPTED_ARCHIVE_PASSWORD ARCHIVE_PASSWORD FILE_PASSWORD (encrypt|decrypt)"
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

if [ "$4" = "encrypt" ]; then
    encryptSingleFiles "$3"
    zpaq add "$scriptDir/secrets.zpaq" "$(
        realpath --relative-to "$scriptDir" "$LOCKED_DIR"
    )" -key "$2" -m5
    gpgEncrypt "$scriptDir/secrets.zpaq" "$scriptDir/secrets.zpaq.gpg" "$1"
elif [ "$4" = "decrypt" ]; then
    gpgDecrypt "$scriptDir/secrets.zpaq.gpg" "$scriptDir/secrets.zpaq" "$1"
    zpaq extract "$scriptDir/secrets.zpaq" -key "$2" -force
    decryptSingleFiles "$3"
else
    scriptHelp
fi
