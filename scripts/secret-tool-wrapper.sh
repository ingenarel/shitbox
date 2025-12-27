#!/usr/bin/sh

secret-tool lookup "$@" || {
    sleep 60
    secret-tool lookup "$@"
}
