#!bin\sh

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'

##************************** Mirror Configuration *************************************##
echo -e "${MSGCOLOUR}Configuring mirrors for fastest speeds..${NC}"
while true ; do
    echo -e -n "${PROMPTCOLOUR}Enter Country Code:${NC} "; read countrycode
    if [ ! -z $countrycode ]; then break; fi
done
#pacman -Syy
#pacman -S reflector
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
#reflector -c "'"'$countrycode'"'" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

##************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
echo -e -n "${PROMPTCOLOUR}Enter Kernel:${NC} "; read kernel
while true ; do
    if [ ! -z $kernel ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter Kernel:${NC} "; read kernel
done
while true ; do
    if [ ! -z $mount ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter Mount Directory:${NC} "; read mount
done
#pacstrap $mount base base-devel $kernel linux-firmware 

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
#genfstab -U $mount >> $mount/etc/fstab

##************************** chrooting *************************************##
echo -e "${MSGCOLOUR}Chrooting into arch installation...${NC}"
#arch-chroot $mount 

##************************** local date and time ******************************##
echo -e "${MSGCOLOUR}Configuring local time and date....${NC}"
#timedatectl set-ntp true
echo -e -n "${PROMPTCOLOUR}Enter Region:${NC} "; read region 
while true ; do
    if [ ! -z $region ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter Region:${NC} "; read region
done
while true ; do
    if [ ! -z $city ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter City:${NC} "; read city 
done
#ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime
#hwclock --systohc
#locale-gen

##************************** Localisation *************************************##

echo -e "${MSGCOLOUR}Configuring localisation...${NC}"
echo -e "${MSGCOLOUR}Creating backup /etc/locale.gen file at /etc/locale.gen.bak${NC}"
#cp /etc/locale.gen /etc/locale.gen.bak
while true ; do
    if [ ! -z $locale ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter Locale:${NC} "; read locale
done
#sed -i 's/#'$locale.UTF-8'/'$locale.UTF-8'/g' etc/locale.gen
#sed -i 's/#'$locale[[:space:]]ISO-8859-1'/'$locale\s^CO-8859-1'/g' etc/locale.gen
echo -e "${MSGCOLOUR}Setting language in /etc/locale.conf to '$locale.UTF-8'${NC}"
#echo "LANG='$locale.UTF-8'" > /etc/locale.conf
#export "LANG='$locale.UTF-8'"

##************************** Host Configuration *************************************##
echo -e "${MSGCOLOUR}Setting up host and hostname settings.....${NC}"
while true ; do
    if [ ! -z $hostname ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter Hostname:${NC} "; read hostname
done
#echo "'$hostname'" > /etc/hostname 
host="
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"
#echo "$host" > /etc/hosts

##************************** Setting root password *************************************##
echo -e "${MSGCOLOUR}Setting root password.....${NC}"
#passwd

##************************** Installing Bootloader *************************************##
echo -e "${MSGCOLOUR}Installing grub bootloader....."
#pacman -S grub efibootmgr 

echo -e "${MSGCOLOUR}Installing microcode...."
while [[ "$microcode" != "intel-ucode" && "$microcode" != "amd-ucode" ]]
do
    echo -e -n "${PROMPTCOLOUR}Enter Microcode [intel-ucode | amd-ucode]: "; read microcode
done
#pacman -S $microcode

echo -e "${MSGCOLOUR}Configuring grub...."
while true ; do
    if [ ! -z $efimount ]; then break; fi
    echo -e -n "${PROMPTCOLOUR}Enter EFI Mount:${NC}"; read efimount
done
#grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=$efimount
#grub-mkconfig -o /boot/grub/grub.cfg

##************************** Installing network tools and graphical environment *************************************##


