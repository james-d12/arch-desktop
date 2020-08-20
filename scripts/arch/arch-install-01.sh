#!bin\sh

. arch-install-config.sh

#************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap $mnt base base-devel $kernel linux-firmware nano

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U $mnt >> $mnt/etc/fstab

##************************** chrooting *************************************##
echo -e "${MSGCOLOUR}Chrooting into arch installation...${NC}"
arch-chroot $mnt 