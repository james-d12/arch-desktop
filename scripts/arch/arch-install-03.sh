#!bin\bash

. ./arch-config.shg.sh

##************************** Installing Application Packages *************************************##
echo -e "${MSGCOLOUR}Running package installation script.....${NC}"
bash ./arch-packages.sh

if [ ! "$EUID" -ne 0 ]; then 
    echo -e "${MSGCOLOUR}Running AUR package installation script.....${NC}"
    bash ./arch-packages-aur.sh  
    exit
else
    echo -e "${MSGCOLOUR}Could not install AUR packages running with heightened privileges.....${NC}"
fi

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

systemctl enable gdm.service 
systemctl enable NetworkManager.service 
systemctl enable ufw.service 
systemctl enable apparmor.service

##************************** Network Security Configuration ******************************##
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