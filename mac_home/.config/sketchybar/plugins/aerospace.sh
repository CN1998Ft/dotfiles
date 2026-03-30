#!/usr/bin/env bash

if [[ "$1" = "$FOCUSED_WORKSPACE" ]]; then
	sketchybar --set $NAME background.drawing=on \
		label.font="Hack Nerd Font:Bold:14.0" \
		label="$1"
else
	sketchybar --set $NAME background.drawing=off \
		label.font="Hack Nerd Font:regular:14.0" \
		label="$1"
fi
