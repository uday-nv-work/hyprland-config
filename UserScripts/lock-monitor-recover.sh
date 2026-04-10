#!/bin/bash
# Recovers hyprlock keyboard input when an external monitor is unplugged
# while the session is locked. Polls monitor count and, on a drop while
# hyprlock is running, refocuses the laptop display so the lock surface
# regains keyboard focus.

LAPTOP_DESC="desc:AU Optronics 0x223D"
prev_count=$(hyprctl monitors -j | jq 'length')

while sleep 2; do
    count=$(hyprctl monitors -j | jq 'length' 2>/dev/null) || continue

    if [ "$count" -lt "$prev_count" ] && pgrep -x hyprlock >/dev/null; then
        # Give Hyprland a beat to settle after the monitor change
        sleep 0.4
        hyprctl dispatch focusmonitor "$LAPTOP_DESC" >/dev/null 2>&1
    fi

    prev_count=$count
done
