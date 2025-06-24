#!/usr/bin/env bash

grep -qEi "application/pdf" "$HOME/.config/mimeapps.list" || xdg-mime default org.pwmt.zathura.desktop application/pdf
