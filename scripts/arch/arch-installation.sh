#!bin\sh

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'

# Parameters

kernel="linux-lts"
locale="en_GB"
mnt="/mnt"
region="Europe"
city="London"
hostname="arch-pc"
host="
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"
microcode="intel-ucode"


##************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap $mnt base base-devel $kernel linux-firmware 

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U $mnt >> $mnt/etc/fstab

##************************** chrooting *************************************##
echo -e "${MSGCOLOUR}Chrooting into arch installation...${NC}"
arch-chroot $mnt 

##************************** local date and time ******************************##
echo -e "${MSGCOLOUR}Configuring local time and date....${NC}"
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime
hwclock --systohc

##************************** Localisation *************************************##

echo -e "${MSGCOLOUR}Configuring localisation...${NC}"
echo -e "${MSGCOLOUR}Creating backup /etc/locale.gen file at /etc/locale.gen.bak${NC}"
cp /etc/locale.gen /etc/locale.gen.bak
sed -i 's/#'$locale.UTF-8'/'$locale.UTF-8'/g' etc/locale.gen
sed -i 's/#'$locale[[:space:]]ISO-8859-1'/'$locale\s^CO-8859-1'/g' etc/locale.gen
echo -e "${MSGCOLOUR}Setting language in /etc/locale.conf to '$locale.UTF-8'${NC}"
echo "LANG='$locale.UTF-8'" > /etc/locale.conf
export "LANG='$locale.UTF-8'"
locale-gen

##************************** Host Configuration *************************************##
echo -e "${MSGCOLOUR}Setting up host and hostname settings.....${NC}"
echo "'$hostname'" > /etc/hostname 
echo "$host" > /etc/hosts

##************************** Setting root password *************************************##
echo -e "${MSGCOLOUR}Setting root password.....${NC}"
passwd

##************************** Installing Bootloader *************************************##
echo -e "${MSGCOLOUR}Installing grub bootloader and microcode....."
pacman -S grub efibootmgr $microcode
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=$mnt
grub-mkconfig -o /boot/grub/grub.cfg

##************************** Installing network tools and graphical environment *************************************##
sh ./install-packages.sh

##************************** Enable Systemd Services *************************************##
systemctl enable NetworkManager
systemctl enable gdm
systemctl enable ufw