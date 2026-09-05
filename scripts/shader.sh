#!/usr/bin/env bash

SHADER_PATH="$HOME/.config/hypr/shaders/almost_bw.frag"
CONFIG="$HOME/.config/hypr/shaders.lua"

CURRENT=$(hyprctl getoption decoration:screen_shader -j | jq -r '.str')

if [ "$CURRENT" = "[[EMPTY]]" ] || [ -z "$CURRENT" ]; then
  echo "hl.config({ decoration = { screen_shader = '$SHADER_PATH' } })" >"$CONFIG"
else
  echo "hl.config({ decoration = { screen_shader = '' } })" >"$CONFIG"
fi

hyprctl reload
