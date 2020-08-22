#!bin\bash

. ./arch-config.sh

if ! pacman -Qs yay > /dev/null; then
    mkdir -p temp
    cd temp
    git clone https://aur.archlinux.org/yay.git
    cd yay 
    makepkg -si
fi

packages=(
    'gconf'                         # Utility
    'gnome-terminal-transparency'   # Gnome-Terminal With Transparency Support
    'bitwarden-bin'                 # Password Manager
    'brave-bin'                     # Privacy Focused Web Browser
    'godot'                         # Lightweight Game-Engine
    'unity-editor-lts'              # Unity3D Engine
    'zeal-git'                      # Offline Documentation Viewer
)

touch pkgs.txt
for pkg in "${packages[@]}"; do
    echo "$pkg" >> pkgs.txt
done
yay -S --noconfirm --needed - < pkgs.txt
rm -rf pkgs.txt