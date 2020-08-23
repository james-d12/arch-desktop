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
yay -S --noconfirm --needed ${packagesaur[@]}

##************************** Installing PIP Packages *************************************##
export PATH=/home/$user/.local/bin:$PATH
echo -e "${MSGCOLOUR}Installing PIP packages.....${NC}"
pip install ${packagespip[@]}

##************************** Installing VSCODE Extensions *************************************##
echo -e "${MSGCOLOUR}Installing VSCode extensions.....${NC}"
for ext in ${extensionscode[@]}; do 
    code --install-extension $ext
done

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

if sudo pacman -Qs sddm > /dev/null ; then
    echo -e "${MSGCOLOUR}Enabling sddm systemd service....${NC}"
    systemctl enable sddm.service
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

