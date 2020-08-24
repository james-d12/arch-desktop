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
    echo -e "${MSGCOLOUR}Installing YAY.....${NC}"
    if [ ! pacman -Qs yay > /dev/null ]; then
        git clone https://aur.archlinux.org/yay.git
        cd yay 
        makepkg -si
    fi
    echo -e "${MSGCOLOUR}Installing AUR packages.....${NC}"
    yay -S --batchinstall --cleanafter --noconfirm --needed ${packagesaur[@]}
fi

##************************** Installing PIP Packages *************************************##
if [ sudo pacman -Qs pip > /dev/null ]; then
    if [ ! ${#packagespip[@]} -eq 0 ]; then  
        echo -e "${MSGCOLOUR}Installing PIP packages.....${NC}"
        pip install ${packagespip[@]}
        export PATH=/home/$user/.local/bin:$PATH
    fi
fi

##************************** Installing VSCODE Extensions *************************************##
if [ sudo pacman -Qs code > /dev/null ]; then
    if [ ! ${#extensionscode[@]} -eq 0 ]; then 
        echo -e "${MSGCOLOUR}Installing VSCode extensions.....${NC}"
        for ext in ${extensionscode[@]}; do 
            code --install-extension $ext
        done
    fi 
fi

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

pacman -Qs gdm > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling gdm systemd service....${NC}"; systemctl enable gdm.service; }

pacman -Qs lightdm > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling lightdm systemd service....${NC}"; systemctl enable lightdm.service; }

pacman -Qs sddm > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling sddm systemd service....${NC}"; systemctl enable sddm.service; }

pacman -Qs networkmanager > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling networkmanager systemd service....${NC}";     systemctl enable NetworkManager.service; }

pacman -Qs ufw > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling ufw systemd service....${NC}";     systemctl enable ufw.service; }

pacman -Qs apparmor > /dev/null && \ 
{ echo -e "${MSGCOLOUR}Enabling apparmor systemd service....${NC}";     systemctl enable apparmor.service; }

