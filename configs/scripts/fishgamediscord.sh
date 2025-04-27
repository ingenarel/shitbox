#!/usr/bin/env bash

while true; do
    for (( i=0; i<100; i++ )); do
        sleep 2.8;
        hyprctl dispatch sendshortcut ', slash, class:(vesktop)';
        sleep 0.3;
        hyprctl dispatch sendshortcut ', f, class:(vesktop)';
        hyprctl dispatch sendshortcut ', i, class:(vesktop)';
        hyprctl dispatch sendshortcut ', s, class:(vesktop)';
        hyprctl dispatch sendshortcut ', h, class:(vesktop)';
        sleep 0.3;
        hyprctl dispatch sendshortcut ', return, class:(vesktop)';
        hyprctl dispatch sendshortcut ', return, class:(vesktop)';
    done;

    sleep 1;
    hyprctl dispatch sendshortcut ', slash, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', s, class:(vesktop)';
    hyprctl dispatch sendshortcut ', e, class:(vesktop)';
    hyprctl dispatch sendshortcut ', l, class:(vesktop)';
    hyprctl dispatch sendshortcut ', l, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', return, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', a, class:(vesktop)';
    hyprctl dispatch sendshortcut ', l, class:(vesktop)';
    hyprctl dispatch sendshortcut ', l, class:(vesktop)';
    hyprctl dispatch sendshortcut ', return, class:(vesktop)';

    sleep 1;
    hyprctl dispatch sendshortcut ', slash, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', b, class:(vesktop)';
    hyprctl dispatch sendshortcut ', u, class:(vesktop)';
    hyprctl dispatch sendshortcut ', y, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', return, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', l, class:(vesktop)';
    hyprctl dispatch sendshortcut ', e, class:(vesktop)';
    hyprctl dispatch sendshortcut ', e, class:(vesktop)';
    hyprctl dispatch sendshortcut ', c, class:(vesktop)';
    hyprctl dispatch sendshortcut ', h, class:(vesktop)';
    hyprctl dispatch sendshortcut ', e, class:(vesktop)';
    hyprctl dispatch sendshortcut ', s, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', tab, class:(vesktop)';
    hyprctl dispatch sendshortcut ', a, class:(vesktop)';
    hyprctl dispatch sendshortcut ', m, class:(vesktop)';
    hyprctl dispatch sendshortcut ', o, class:(vesktop)';
    hyprctl dispatch sendshortcut ', u, class:(vesktop)';
    hyprctl dispatch sendshortcut ', n, class:(vesktop)';
    hyprctl dispatch sendshortcut ', t, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', return, class:(vesktop)';
    hyprctl dispatch sendshortcut ', 5, class:(vesktop)';
    hyprctl dispatch sendshortcut ', 0, class:(vesktop)';
    sleep 0.3;
    hyprctl dispatch sendshortcut ', return, class:(vesktop)';
done;
