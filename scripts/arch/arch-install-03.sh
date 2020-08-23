#!bin\bash

. ./arch-config.sh
. resources/packages.sh

### This Script is run on reboot as user NOT ROOT ###

##************************** Installing Packages *************************************##
echo -e "${MSGCOLOUR}Running package installation script.....${NC}"
defile="resources/${desktopenvironment}.sh"
. ./$defile
sudo pacman -S --noconfirm --needed ${depackages[@]}
sudo pacman -S --noconfirm --needed ${packages[@]}

##************************** Installing AUR Packages *************************************##
echo -e "${MSGCOLOUR}Installing AUR packages.....${NC}"
if ! pacman -Qs yay > /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay 
    makepkg -si
fi
yay -S --noconfirm --needed ${packages-aur[@]}

##************************** Installing PIP Packages *************************************##
export PATH=/home/$user/.local/bin:$PATH
echo -e "${MSGCOLOUR}Installing PIP packages.....${NC}"
pip install ${packages-pip[@]}


##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"

if sudo pacman -Qs gdm > /dev/null ; then
echo -e "${MSGCOLOUR}Enabling gdm systemd service....${NC}"
    systemctl enable gdm.service
fi

if sudo pacman -Qs lightdm > /dev/null ; then
echo -e "${MSGCOLOUR}Enabling lightdm systemd service....${NC}"
    systemctl enable lightdm.service
fi

if sudo pacman -Qs networkmanager > /dev/null ; then
echo -e "${MSGCOLOUR}Enabling networkmanager systemd service....${NC}"
    systemctl enable NetworkManager.service
fi

if sudo pacman -Qs ufw > /dev/null; then 
echo -e "${MSGCOLOUR}Enabling ufw systemd service....${NC}"
    systemctl enable ufw.service
fi

if sudo pacman -Qs apparmor > /dev/null; then 
echo -e "${MSGCOLOUR}Enabling apparmor systemd service....${NC}"
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

sudo cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

if sudo pacman -Qs fail2ban > /dev/null; then
    sudo cp fail2ban.local /etc/fail2ban/
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
fi

if sudo pacman -Qs netstat-nat > /dev/null; then
    echo "listening ports"
    sudo netstat -tunlp
fi

##************************** Performance Improvements ******************************##

su -c touch /etc/sysctl.d/99-swappiness.conf  
su -c echo "vm.swappiness=10" >> /etc/sysctl.d/99-swappiness.conf      
    
##************************** SSD Performance Improvements ******************************##

if [ $ssd == "YES" ]; then
    sudo systemctl enable fstrim.timer
fi
