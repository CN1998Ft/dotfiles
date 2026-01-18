#!/usr/bin/env bash

cask=($(brew list --cask))
sketchybar --set $NAME label="${#cask[@]} cask"
