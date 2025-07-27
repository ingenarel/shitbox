#!/usr/bin/env bash

mw -l || {
    pass init 82F50B33201B8D6A54127C7C884988B67CE8CCDB
    mw\
        -a 'ingenarelitems@gmail.com'\
        -x "$(
            keepassxc-cli\
                show\
                --show-protected\
                --attributes 'app password'\
                "$HOME/.config/shitbox/configs/secrets/passwords/Passwords.kdbx"\
                'neomutt login'\
        )"\
        -o
}
