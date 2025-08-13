#!/usr/bin/env bash
echo "Locking the fuck in"
systemctl --user stop mpd-discord-rpc
sudo systemctl stop tailscaled
pkill waybar
