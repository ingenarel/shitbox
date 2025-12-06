#!/usr/bin/sh

secret-tool lookup mail main || {
    sleep 60
    secret-tool lookup mail main
}
