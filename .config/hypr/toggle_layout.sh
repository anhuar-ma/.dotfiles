#!/usr/bin/env bash

# 1. Get current Workspace ID
WORKSPACENUM=$(hyprctl activeworkspace -j | jq -r '.id')
echo "Active Workspace: $WORKSPACENUM"

# 2. Define State File
STATEFILE="/tmp/hypr_wslayout_state_$WORKSPACENUM"

# 3. Check State (Default to 'dwindle' if unknown)
if [ -f "$STATEFILE" ]; then
    CURRENT_LAYOUT=$(cat "$STATEFILE")
else
    CURRENT_LAYOUT="dwindle"
fi

# 4. Toggle Logic
if [ "$CURRENT_LAYOUT" == "dwindle" ]; then
    # Switch to Master
    # The plugin expects 'master', 'dwindle', or 'nstack'
    hyprctl dispatch layoutmsg setlayout master 
    
    echo "hy3" > "$STATEFILE"
    notify-send "Workspace $WORKSPACENUM" "Layout: hy3" -t 1000
else
    # Switch to Dwindle
    hyprctl dispatch layoutmsg setlayout dwindle
    
    echo "dwindle" > "$STATEFILE"
    notify-send "Workspace $WORKSPACENUM" "Layout: Dwindle" -t 1000
fi
