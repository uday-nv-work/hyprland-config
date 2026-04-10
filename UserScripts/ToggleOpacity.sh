#!/bin/bash

CONF="$HOME/.config/hypr/UserConfigs/UserDecorations.conf"

current=$(grep -m1 'active_opacity' "$CONF" | grep -o '[0-9.]*')

if [ "$current" = "1.0" ]; then
    sed -i 's/active_opacity = 1.0/active_opacity = 0.95/' "$CONF"
    sed -i 's/inactive_opacity = 1.0/inactive_opacity = 0.88/' "$CONF"
else
    sed -i "s/active_opacity = .*/active_opacity = 1.0/" "$CONF"
    sed -i "s/inactive_opacity = .*/inactive_opacity = 1.0/" "$CONF"
fi

hyprctl reload
