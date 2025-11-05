#!/usr/bin/sh

while sleep "$(( 60 * 30 ))"; do
    notify-send -u critical 'HALF AN HOUR PASSED YOU MORON' & paplay /home/ingenarel/.config/shitbox/sounds/error.mp3
done
