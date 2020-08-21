#!bin\bash

##************************** Installing Application Packages *************************************##
echo -e "${MSGCOLOUR}Running package installation script.....${NC}"
bash ./arch-packages.sh

if [ "$EUID" -ne 0 ]; then 
    echo -e "${MSGCOLOUR}Could not install AUR packages running with heightened privileges.....${NC}"
else
    echo -e "${MSGCOLOUR}Running AUR package installation script.....${NC}"
    bash ./arch-packages-aur.sh  
fi

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

if pacman -Qs gdm > /dev/null ; then
    systemctl enable gdm.service
fi

if pacman -Qs networkmanager > /dev/null ; then
    systemctl enable NetworkManager.service
fi

if pacman -Qs ufw > /dev/null; then 
    systemctl enable ufw.service
fi

if pacman -Qs apparmor > /dev/null; then 
    systemctl enable apparmor.service
fi

##************************** Network Security Configuration ******************************##

if pacman -Qs ufw > /dev/null; then
    sudo ufw limit 22/tcp  
    sudo ufw limit ssh
    sudo ufw allow 80/tcp  
    sudo ufw allow 443/tcp  
    sudo ufw default deny
    sudo ufw default deny incoming  
    sudo ufw default allow outgoing
    sudo allow from 192.168.0.0/24
    sudo allow Deluge
    sudo ufw enable
fi


##************************** Finish and Cleanup ******************************##
shutdown now