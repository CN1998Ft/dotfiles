#!/usr/bin/env bash

total=$(aerospace list-workspaces --all --count)
sketchybar --set $NAME label="$FOCUSED_WORKSPACE / $total"
# if [[ "$1" == "$FOCUSED_WORKSPACE" ]]; then
# 	sketchybar --set $NAME label=""
# else
# 	sketchybar --set $NAME label=""
# fi
