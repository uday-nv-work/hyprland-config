#!/bin/bash
# Custom workspace startup script for complex layout
# Workspace 1: Teams PWA
# Workspace 2: Split screen with Brave intech profile + Ghostty
# Workspace 3: Spotify in Brave pvt profile

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

# Workspace 1: Launch Teams PWA using exact desktop entry command
echo "Setting up Workspace 1 - Teams PWA"
hyprctl dispatch workspace 1
# Launch Teams PWA using the exact command from desktop entry
/opt/brave.com/brave/brave-browser "--profile-directory=Profile 5" --app-id=cifhbcnohmdccbgoicgdjpfamggdegmo &
sleep 2

# Workspace 2: Split screen setup
echo "Setting up Workspace 2 - Split screen (Brave + Ghostty)"
hyprctl dispatch workspace 2

# Pre-configure the workspace layout BEFORE launching apps
hyprctl dispatch splitratio exact:0.5

# Launch Ghostty first (it handles resizing better)
ghostty &
sleep 1
wait_for_app "ghostty"

# Now launch Brave - it will open in the remaining split space
# Nuclear option flags for Brave 140.x viewport regression
/opt/brave.com/brave/brave-browser "--profile-directory=Profile 5" --disable-features=UseOzonePlatform,VizDisplayCompositor --disable-gpu --disable-software-rasterizer --force-device-scale-factor=1 --disable-dev-shm-usage --no-sandbox &
sleep 1
wait_for_app "Brave-browser"

# Focus ghostty by default
hyprctl dispatch focuswindow "class:ghostty"

# Workspace 3: Launch Spotify (create PWA first if needed)
echo "Setting up Workspace 3 - Spotify"
hyprctl dispatch workspace 3
# Launch Spotify with Default profile (usually the personal/private one)
/opt/brave.com/brave/brave-browser "--profile-directory=Default" --app="https://open.spotify.com" --disable-gpu &
sleep 2
# Ensure it's in the right workspace (force move if needed)
hyprctl dispatch movetoworkspacesilent 3,class:^(Brave-browser)

# Return to workspace 1
hyprctl dispatch workspace 1

echo "Workspace startup completed"