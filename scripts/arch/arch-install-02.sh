#!bin\sh

. ./arch-install-config.sh

##************************** Enable Multilib repository ******************************##
echo -e "${MSGCOLOUR}Enabling multilib repository....${NC}"
echo -e "${MSGCOLOUR}Creating backup /etc/pacman.conf file at /etc/pacman.conf.bak${NC}"
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i 's/#[multilib]/[multilib]/g' /etc/pacman.conf
sed -i 's/"#Include[[:space:]]=[[:space:]]/etc/pacman.d/mirrorlist"/"Include[[:space:]]=[[:space:]]/etc/pacman.d/mirrorlist"/g' /etc/pacman.conf

##************************** local date and time ******************************##
echo -e "${MSGCOLOUR}Configuring local time and date....${NC}"
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime
hwclock --systohc

##************************** Localisation *************************************##

echo -e "${MSGCOLOUR}Configuring localisation...${NC}"
echo -e "${MSGCOLOUR}Creating backup /etc/locale.gen file at /etc/locale.gen.bak${NC}"
cp /etc/locale.gen /etc/locale.gen.bak
sed -i 's/#$locale.UTF-8/$locale.UTF-8/g' /etc/locale.gen
sed -i 's/#$locale[[:space:]]ISO-8859-1/$locale[[:space:]]ISO-8859-1/g' /etc/locale.gen
echo -e "${MSGCOLOUR}Setting language in /etc/locale.conf to '$locale.UTF-8'${NC}"
echo "LANG=$locale.UTF-8" > /etc/locale.conf
export "LANG=$locale.UTF-8"
locale-gen

##************************** Host Configuration *************************************##
echo -e "${MSGCOLOUR}Setting up host and hostname settings.....${NC}"
echo "$hostname" > /etc/hostname 
echo "$host" > /etc/hosts

##************************** Setting root password *************************************##
echo -e "${MSGCOLOUR}Setting root password.....${NC}"
passwd

##************************** Installing Bootloader *************************************##
echo -e "${MSGCOLOUR}Installing grub bootloader and microcode.....${NC}"
pacman -S grub efibootmgr $microcode
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=$efimnt
grub-mkconfig -o /boot/grub/grub.cfg

##************************** Adding a User *************************************##
echo -e "${MSGCOLOUR}Creating the user $user for group $usergroup.....${NC}"
useradd -m -G $usergroup $user 
passwd $user

##************************** Installing Desktop Environment *************************************##
pacman -S --noconfirm $desktop 

##************************** Installing Application Packages *************************************##
echo -e "${MSGCOLOUR}Running package installation scripts.....${NC}"
sh ./install-packages.sh

##************************** Enable Systemd Services *************************************##
echo -e "${MSGCOLOUR}Enabling systemd services....${NC}"
systemctl enable NetworkManager.service
systemctl enable ufw.service
