#!bin\bash

packages=(
    'gconf' 
    'gnome-terminal-transparency' 
    'bitwarden-bin' 
    'godot'
    'zeal-git'
    'unity-editor-lts'
)

touch pkgs.txt
for pkg in "${packages[@]}"; do
    echo "$pkg" >> pkgs.txt
done
yay -S --noconfirm --needed - < pkgs.txt
rm -rf pkgs.txt