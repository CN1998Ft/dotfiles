#!/usr/bin/env bash

aerospace_workspaces=$(aerospace list-workspaces --all)
focused=$(aerospace list-workspaces --focused)
for workspace in "${aerospace_workspaces[@]}"; do
	if [[ "$1" = "$FOCUSED_WORKSPACE" ]]; then
		sketchybar --set $NAME background.drawing=on
		sketchybar --set $NAME label.drawing=on
		sketchybar --move $NAME before chevron
	fi
done
