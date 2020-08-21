#!bin\sh

. ./arch-install-config.sh


##************************** Encrypted Install - Add SWAP ******************************##
if [ $encrypted == "YES" ]; then
    echo -e "${MSGCOLOUR}Adding encrypted SWAP file....${NC}"
    dd if=/dev/zero of=/swapfile bs=1M count=$encryptedswapsize status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo -e "${MSGCOLOUR}Backing up /etc/fstab to /etc/fstab.bak....${NC}"
    cp /etc/fstab /etc/fstab.bak
    echo "/swapfile none swap sw 0 0" >> /etc/fstab
fi

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

if [ $encrypted == "YES" ]; then
    echo -e "${MSGCOLOUR}Configuring GRUB for encrypted install.....${NC}"
    echo -e "${MSGCOLOUR}Backing up file /etc/default/grub to /etc/default/grub.bak.....${NC}"
    cp /etc/default/grub /etc/default/grub.bak
    sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cryptdevice=/dev/"${drive}3:$encryptedname"/g' /etc/default/grub
    echo -e "${MSGCOLOUR}Backing up file /etc/mkinitcpio.conf to /etc/mkinitcpio.conf.bak.....${NC}"
    sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck/g' /etc/mkinitcpio.conf
    mkinitcpio -p $kernel
fi

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
