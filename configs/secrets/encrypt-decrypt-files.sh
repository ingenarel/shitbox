#!/usr/bin/env bash

scriptDir="$(realpath --canonicalize-missing "${BASH_SOURCE[0]}/..")"

sshDecryptedFile="$scriptDir/ssh/git"
sshEncryptedFile="$scriptDir/ssh/git.gpg"
kdbxDecryptedFile="$scriptDir/passwords/Passwords.kdbx"
kdbxEncryptedFile="$scriptDir/passwords/Passwords.kdbx.gpg"
kdbxBackupDecryptedFile="$scriptDir/passwords/PasswordsBackup.kdbx"
kdbxBackupEncryptedFile="$scriptDir/passwords/PasswordsBackup.kdbx.gpg"
gpgSignDecryptedFile="$scriptDir/gpg/gitSign"
gpgSignEncryptedFile="$scriptDir/gpg/gitSign.gpg"
neomuttDecryptedFile="$scriptDir/gpg/neomutt"
neomuttEncryptedFile="$scriptDir/gpg/neomutt.gpg"

encryptFile() {
    if [[ ! -e "$1" ]]; then
        echo "DECRYPTED FILE NOT FOUND!"
        return 1;
    fi

    if [[ -e "$2" ]]; then
        rm "$2"
    fi

    gpg --symmetric \
        --batch \
        --cipher-algo AES256 \
        --digest-algo SHA512 \
        --compress-algo ZLIB \
        --s2k-mode 3 \
        --s2k-digest-algo SHA512 \
        --s2k-cipher-algo AES256 \
        --s2k-count 65011712 \
        --passphrase "$3"\
        "$1"
}

decryptFile() {
    if [[ ! -e "$2" ]]; then
        echo "ENCRYPTED FILE NOT FOUND!"
        return 1;
    fi

    if [[ -e "$1" ]]; then
        rm "$1"
    fi

    gpg --batch --yes --passphrase "$3" --output "$1" --decrypt "$2"
}

if [[ "$2" == "encrypt" ]]; then
    encryptFile "$sshDecryptedFile" "$sshEncryptedFile" "$1"
    encryptFile "$kdbxDecryptedFile" "$kdbxEncryptedFile" "$1"
    encryptFile "$kdbxBackupDecryptedFile" "$kdbxBackupEncryptedFile" "$1"
    encryptFile "$gpgSignDecryptedFile" "$gpgSignEncryptedFile" "$1"
    encryptFile "$neomuttDecryptedFile" "$neomuttEncryptedFile" "$1"
elif [[ "$2" == "decrypt" ]]; then
    decryptFile "$sshDecryptedFile" "$sshEncryptedFile" "$1"
    if [[ ! -d "$HOME/.ssh" ]]; then
        mkdir "$HOME/.ssh"
    fi
    cp -f "$sshDecryptedFile" "$HOME/.ssh/git"
    chmod 600 "$HOME/.ssh/git"
    cp "${sshDecryptedFile}.pub" "$HOME/.ssh/git.pub"
    cp "$scriptDir/ssh/config" "$HOME/.ssh/config"
    decryptFile "$kdbxDecryptedFile" "$kdbxEncryptedFile" "$1"
    decryptFile "$kdbxBackupDecryptedFile" "$kdbxBackupEncryptedFile" "$1"
    decryptFile "$gpgSignDecryptedFile" "$gpgSignEncryptedFile" "$1"
    decryptFile "$neomuttDecryptedFile" "$neomuttEncryptedFile" "$1"
    gpg --import "$gpgSignDecryptedFile"
    gpg --import "${gpgSignDecryptedFile}.pub"
    gpg --edit-key "66D11DC0EFAC2F99D0A687F91E81128A3F325C35"
    gpg --import "$neomuttDecryptedFile"
    gpg --import "${neomuttDecryptedFile}.pub"
    gpg --edit-key "82F50B33201B8D6A54127C7C884988B67CE8CCDB"
elif [[ -z $1 || $1 == "--help" || $1 == "-h" ]]; then
    echo "$scriptDir/encrypt-decrypt-files.sh PASSWORD (encrypt|decrypt)"
fi
