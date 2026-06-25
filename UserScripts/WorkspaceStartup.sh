#!/bin/bash
# Custom workspace startup script
# Workspace 1: Ghostty
# Workspace 2: Brave intech profile (Profile 5)
# Workspace 3: Teams PWA + Brave intech
# Special  : kitty dropdown (launched from Startup_Apps.conf)

# Wait for Hyprland to be fully ready
sleep 3

# Function to wait for application to appear
wait_for_app() {
    local app_class="$1"
    local timeout=10
    local count=0

    while [ $count -lt $timeout ]; do
        if hyprctl clients | grep -q "class: $app_class"; then
            return 0
        fi
        sleep 1
        ((count++))
    done
    return 1
}

# Workspace 1: Ghostty
echo "Setting up Workspace 1 - Ghostty"
hyprctl dispatch workspace 1
ghostty &
wait_for_app "ghostty"

# Workspace 2: Brave intech profile
echo "Setting up Workspace 2 - Brave (intech)"
hyprctl dispatch workspace 2
/opt/brave.com/brave/brave-browser "--profile-directory=Profile 5" &
sleep 2

# Workspace 3: Teams PWA + Brave intech
echo "Setting up Workspace 3 - Teams PWA + Brave"
hyprctl dispatch workspace 3
/opt/brave.com/brave/brave-browser "--profile-directory=Profile 5" --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo &
sleep 2

# Return to workspace 1
hyprctl dispatch workspace 1

echo "Workspace startup completed"