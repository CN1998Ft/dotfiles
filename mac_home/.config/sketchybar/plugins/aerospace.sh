#!/usr/bin/env bash

if [[ "$1" = "$FOCUSED_WORKSPACE" ]]; then
    sketchybar --set $NAME background.drawing=on
    sketchybar --set $NAME label.color=$BLACK
else
    sketchybar --set $NAME background.drawing=off
    sketchybar --set $NAME label.color=$BLACKGREEN
fi

# total=$(aerospace list-workspaces --all --count)
# sketchybar --set $NAME label="$FOCUSED_WORKSPACE / $total"

# if [[ "$1" == "$FOCUSED_WORKSPACE" ]]; then
# 	sketchybar --set $NAME label=""
# else
# 	sketchybar --set $NAME label=""
# fi
