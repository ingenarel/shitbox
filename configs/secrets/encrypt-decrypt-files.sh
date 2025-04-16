#!/usr/bin/env bash

sshDecryptedFile="$HOME/.config/nixos-config/configs/secrets/ssh/git"
sshEncryptedFile="$HOME/.config/nixos-config/configs/secrets/ssh/git.gpg"
kdbxDecryptedFile="$HOME/.config/nixos-config/configs/secrets/passwords/Passwords.kdbx"
kdbxEncryptedFile="$HOME/.config/nixos-config/configs/secrets/passwords/Passwords.kdbx.gpg"
kdbxBackupDecryptedFile="$HOME/.config/nixos-config/configs/secrets/passwords/PasswordsBackup.kdbx"
kdbxBackupEncryptedFile="$HOME/.config/nixos-config/configs/secrets/passwords/PasswordsBackup.kdbx.gpg"

encryptFile() {
    if [[ ! -e "$3" ]]; then
        echo "password file not found"
        return 1
    fi

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
        --passphrase-file "$3"\
        "$1"
}

decryptFile() {
    if [[ ! -e "$3" ]]; then
        echo "password file not found"
        return 1
    fi

    if [[ ! -e "$2" ]]; then
        echo "ENCRYPTED FILE NOT FOUND!"
        return 1;
    fi

    if [[ -e "$1" ]]; then
        rm "$1"
    fi
    gpg --passphrase-file "$3"\ "$2"
}

if [[ "$2" == "encrypt" ]]; then
    encryptFile "$sshDecryptedFile" "$sshEncryptedFile" "$1"
    encryptFile "$kdbxDecryptedFile" "$kdbxEncryptedFile" "$1"
    encryptFile "$kdbxBackupDecryptedFile" "$kdbxBackupEncryptedFile" "$1"
elif [[ "$2" == "decrypt" ]]; then
    encryptFile "$sshDecryptedFile" "$sshEncryptedFile" "$1"
    cp -f "$sshDecryptedFile" "$HOME/.ssh/git"
    chmod 600 "$HOME/.ssh/git"
    encryptFile "$kdbxDecryptedFile" "$kdbxEncryptedFile" "$1"
    encryptFile "$kdbxBackupDecryptedFile" "$kdbxBackupEncryptedFile" "$1"
else
    echo "should i encrypt or decrypt?"
    exit 1
fi
