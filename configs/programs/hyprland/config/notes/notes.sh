#!/usr/bin/env bash

swww img --resize fit -t none "$HOME/.config/hypr/notes/notes.png"
while true; do
    inotifywait -e modify "$HOME/.config/hypr/notes/notes.txt"
    magick -font "/usr/share/fonts/TTF/HackNerdFont-Regular.ttf" -background "#110015" -fill "#FF1163" -size 1440x850 -pointsize 20 caption:"$(cat $HOME/.config/hypr/notes/notes.txt)" $HOME/.config/hypr/notes/notes.png &&\
        swww img --resize fit -t none "$HOME/.config/hypr/notes/notes.png"
done
