#!/usr/bin/env bash
zellij list-sessions && {
    zellij attach
    } || {
    zellij
}
