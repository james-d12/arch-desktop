#!/usr/bin/env bash

. ./arch-config.sh
. resources/packages

### This Script is run on reboot as user NOT ROOT ###

##************************** Installing Packages *************************************##
echo -e "${MSGCOLOUR}Installing packages.....${NC}"
defile="resources/${desktopenvironment}" && . ./$defile
sudo pacman -S --noconfirm --needed ${depackages[@]}
sudo pacman -S --noconfirm --needed ${packages[@]}

##************************** Installing AUR Packages *************************************##
if [ ! ${#packagesaur[@]} -eq 0 ]; then  
    if ! command -v yay > /dev/null; then 
        echo -e "${MSGCOLOUR}Installing YAY.....${NC}"
        git clone https://aur.archlinux.org/yay.git
        cd yay 
        makepkg -si
    fi
    echo -e "${MSGCOLOUR}Installing AUR packages.....${NC}"
    yay -S --batchinstall --cleanafter --noconfirm --needed ${packagesaur[@]}
fi

##************************** Installing PIP Packages *************************************##
if command -v pip > /dev/null; then
    if [ ! ${#packagespip[@]} -eq 0 ]; then  
        echo -e "${MSGCOLOUR}Installing PIP packages.....${NC}"
        pip install ${packagespip[@]}
        export PATH=/home/$user/.local/bin:$PATH
    fi
fi

##************************** Installing VSCODE Extensions *************************************##
if command -v code > /dev/null; then
    if [ ! ${#extensionscode[@]} -eq 0 ]; then 
        echo -e "${MSGCOLOUR}Installing VSCode extensions.....${NC}"
        for ext in ${extensionscode[@]}; do 
            code --install-extension $ext
        done
    fi 
fi

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

if sudo pacman -Qs gdm > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling gdm systemd service....${NC}"; 
    systemctl enable gdm.service;
fi

if sudo pacman -Qs sddm > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling sddm systemd service....${NC}"; 
    systemctl enable sddm.service;
fi

if sudo pacman -Qs lightdm > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling lightdm systemd service....${NC}"; 
    systemctl enable lightdm.service;
fi

if sudo pacman -Qs networkmanager > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling networkmanager systemd service....${NC}"; 
    systemctl enable NetworkManager.service;
fi

if sudo pacman -Qs ufw > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling ufw systemd service....${NC}"; 
    systemctl enable ufw.service;
fi

if sudo pacman -Qs apparmor > /dev/null; then
    echo -e "${MSGCOLOUR}Enabling apparmor systemd service....${NC}"; 
    systemctl enable apparmor.service;
fi