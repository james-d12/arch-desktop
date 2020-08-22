#!bin\bash

### This Script is run on reboot as user NOT ROOT ###

##************************** Installing Application Packages *************************************##
echo -e "${MSGCOLOUR}Running package installation script.....${NC}"
bash ./arch-packages.sh

if [ "$EUID" -ne 0 ]; then 
    echo -e "${MSGCOLOUR}Could not install AUR packages running with heightened privileges.....${NC}"
else
    echo -e "${MSGCOLOUR}Running AUR package installation script.....${NC}"
    bash ./arch-packages-aur.sh  
fi

echo -e "${MSGCOLOUR}Running pip package installation script.....${NC}"
bash ./arch-packages-other.sh

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

if sudo pacman -Qs gdm > /dev/null ; then
    systemctl enable gdm.service
fi

if sudo pacman -Qs lightdm > /dev/null ; then
    systemctl enable lightdm.service
fi

if sudo pacman -Qs networkmanager > /dev/null ; then
    systemctl enable NetworkManager.service
fi

if sudo pacman -Qs ufw > /dev/null; then 
    systemctl enable ufw.service
fi

if sudo pacman -Qs apparmor > /dev/null; then 
    systemctl enable apparmor.service
fi

##************************** Network Security Configuration ******************************##

if sudo pacman -Qs ufw > /dev/null; then
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

if sudo pacman -Qs sysctl > /dev/null; then
    sudo sysctl kernel.modules_disabled=1
    sudo sysctl -a
    sudo sysctl -A
    sudo sysctl mib
    sudo sysctl net.ipv4.conf.all.rp_filter
    sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'
fi

cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

if sudo pacman -Qs fail2ban > /dev/null; then
    sudo cp fail2ban.local /etc/fail2ban/
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
fi

echo "listening ports"
sudo netstat -tunlp


##************************** Performance Improvements ******************************##
sudo echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf      

##************************** SSD Performance Improvements ******************************##

if [ $ssd == "YES" ]; then
    sudo pacman -S --needed --noconfirm util-linux 
    sudo systemctl enable fstrim.timer
fi

##************************** Finish and Cleanup ******************************##
reboot