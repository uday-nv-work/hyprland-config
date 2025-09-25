#!/bin/bash

app=$(rofi -show drun -no-custom | awk '{print $1}')

[ -z "$app" ] && exit 0

running=$(hyprctl clients -j | jq -r --arg app "$app" '
  .[] | select(.class | ascii_downcase == $app or .title | test($app; "i"))
  | "\(.workspace.id)::\(.address)"' | head -n1)

if [ -n "$running" ]; then
	workspace=$(echo "$running" | cut -d: -f1)
	address=$(echo "$running" | cut -d: -f3)

	# Try to switch + focus
	hyprctl dispatch workspace "$workspace"
	sleep 0.3
	hyprctl dispatch focuswindow address:"$address"
else
	# Fall back to launch
	gtk-launch "$app" || nohup "$app" >/dev/null 2>&1 &
fi
