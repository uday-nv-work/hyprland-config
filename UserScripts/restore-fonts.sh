#!/usr/bin/env bash
# Restore Hyprland font gsettings on login.
# Regolith (fallback session) may push Roboto into user-wide gsettings;
# this snaps fonts back to nerd-font defaults for Hyprland.

gsettings set org.gnome.desktop.interface font-name 'ProFont IIx Nerd Font 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'ProFont IIx Nerd Font Mono 12'
gsettings set org.gnome.desktop.interface document-font-name 'ProFont IIx Nerd Font 11'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
