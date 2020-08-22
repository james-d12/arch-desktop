#!bin\bash

# Contains a list of AUR packages to install.

. ./arch-config.sh

packages=(
    'gconf'                         # Utility
    'bitwarden-bin'                 # Password Manager
    'brave-bin'                     # Privacy Focused Web Browser
    'godot'                         # Lightweight Game-Engine
    'unity-editor-lts'              # Unity3D Engine
    'zeal-git'                      # Offline Documentation Viewer
)

if ! pacman -Qs yay > /dev/null; then
    mkdir -p temp
    cd temp
    git clone https://aur.archlinux.org/yay.git
    cd yay 
    makepkg -si
fi

touch pkgs.txt
for pkg in "${packages[@]}"; do
    echo "$pkg" >> pkgs.txt
done
yay -S --noconfirm --needed - < pkgs.txt
rm -rf pkgs.txt