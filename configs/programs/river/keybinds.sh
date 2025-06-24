#!/usr/bin/env bash

riverctl map normal\
    Super Q\
    spawn "
        riverctl\
            rule-add\
            -title $terminal\
            fullscreen\
        &&
        $terminal\
        -e \"$HOME/.config/hypr/scripts/autostart-tmux.sh\"\
        & {
            sleep 0.1
            riverctl\
                rule-del\
                -title $terminal\
                fullscreen;
        }
"
riverctl map normal Super+Shift escape close
riverctl map normal Super R spawn "$HOME/.config/shitbox/scripts/menu.sh $terminal"
riverctl map normal Alt F4 spawn "$HOME/.config/hypr/scripts/shutdown.sh"

riverctl map normal Super h focus-view left
riverctl map normal Super j focus-view down
riverctl map normal Super k focus-view up
riverctl map normal Super l focus-view right
riverctl map-pointer normal Super BTN_LEFT move-view
riverctl map-pointer normal Super BTN_RIGHT resize-view
riverctl map normal Super+Shift V toggle-float

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))
    riverctl map normal Super $i set-focused-tags $tags
    riverctl map normal Super+Shift $i set-view-tags $tags
done

all_tags=$(((1 << 32) - 1))
riverctl map normal Super tab set-focused-tags $all_tags

riverctl map normal Super f11 toggle-fullscreen

riverctl map -repeat normal Super equal spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
riverctl map -repeat normal Super minus spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
riverctl map normal Super Print spawn "$HOME/.config/hypr/scripts/screenshot.sh"
