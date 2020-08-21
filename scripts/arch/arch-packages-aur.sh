#!bin\bash

packages-aur=(
    'gconf' 
    'gnome-terminal-transparency' 
    'bitwarden-bin' 
    'godot'
    'zeal-git'
    'unity-editor-lts'
)

yay -S --needed --noconfirm - < ${packages-aur[@]}
