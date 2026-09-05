#!/bin/bash

# Default to HDMI-A-1, but allow passing DP-3 as an argument
mnt1="HDMI-A-1"
mnt2="DP-3"

# Define the exact Lua commands to enable the monitors
dp3_eval="hl.monitor({ output = 'DP-3', mode = '3840x2160@60.0', position = '3185x1080', scale = 1.2, disabled = false })"
hdmi_eval="hl.monitor({ output = 'HDMI-A-1', mode = '1920x1080@60.0', position = '6385x1355', scale = 1.0, disabled = false })"

current_monitors=$(hyprctl monitors)

# Check if the monitor is currently active in the Hyprland session
if echo "$current_monitors" | grep -q "Monitor $mnt1" && echo "$current_monitors" | grep -q "Monitor $mnt2"; then
  # Disable the monitor using eval and the disabled flag
  hyprctl eval "hl.monitor({ output = '$mnt1', disabled = true })"
  hyprctl eval "hl.monitor({ output = '$mnt2', disabled = true })"
else
  hyprctl eval "$dp3_eval"
  hyprctl eval "$hdmi_eval"
fi
