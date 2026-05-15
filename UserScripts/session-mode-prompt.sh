#!/bin/bash
# Prompt: full session apps or minimal (dropdown terminal only)
# Skipped if SESSION_MODE_AUTO env var is set ("full" or "minimal")

UserScripts="$HOME/.config/hypr/UserScripts"
scriptsDir="$HOME/.config/hypr/scripts"

mode="${SESSION_MODE_AUTO:-}"

if [ -z "$mode" ]; then
    sleep 1
    if zenity --question \
        --title="Session Mode" \
        --text="Launch full session with all apps?\n\nNo = dropdown terminal only" \
        --ok-label="Full" --cancel-label="Minimal" 2>/dev/null; then
        mode="full"
    else
        mode="minimal"
    fi
fi

if [ "$mode" = "full" ]; then
    nm-applet --indicator &
    swaync &
    ags &
    blueman-applet &
    waybar &
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &
    "$UserScripts/RainbowBorders.sh" &
    "$UserScripts/auto-exit-fullscreen-urgent.sh" &
    "$UserScripts/lock-monitor-recover.sh" &
    "$UserScripts/WorkspaceStartup.sh" &
    hyprctl dispatch exec "[workspace special; size 75% 20%; move 12.5% 40] kitty" &
else
    # Minimal: just dropdown terminal in special workspace
    hyprctl dispatch exec "[workspace special; size 75% 20%; move 12.5% 40] kitty" &
    hyprctl dispatch togglespecialworkspace &
fi
