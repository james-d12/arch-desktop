#!bin\bash

packages=(
    'gconf' 
    'gnome-terminal-transparency' 
    'bitwarden-bin' 
    'godot'
    'zeal-git'
    'unity-editor-lts'
)

for pkg in "${packages[@]}"; do
    yay -S "$pkg" --noconfirm --needed
done

