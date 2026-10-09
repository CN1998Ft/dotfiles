#!/usr/bin/env bash

formula=($(brew list --formula))
sketchybar --set $NAME label=" ${#formula[@]} formula"
