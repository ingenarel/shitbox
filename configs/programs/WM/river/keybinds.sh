#!/usr/bin/env bash

mapWithRule(){
    eval "
        riverctl map $1\
            spawn \"
                riverctl\
                    rule-add $2\
                &&
                $3\
                & {
                    sleep 0.1
                    riverctl\
                        rule-del $2;
                }
        \"
    "
}

mapWithRule "normal Super Q" "-title $terminal fullscreen" "$terminal -e '$HOME/.config/shitbox/scripts/autostart-tmux.sh'"

riverctl map normal Super+Shift escape close
riverctl map normal Super R spawn "$HOME/.config/shitbox/scripts/menu.sh $terminal"
riverctl map normal Alt F4 spawn "$HOME/.config/shitbox/scripts/shutdown.sh"

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
riverctl map normal Super Print spawn "$HOME/.config/shitbox/scripts/screenshot.sh"
