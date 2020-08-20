#!bin\sh

. arch-install-config.sh

#************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap $mnt base base-devel $kernel linux-firmware nano

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U $mnt >> $mnt/etc/fstab

mv chroot.sh /mnt
chmod 700 /mnt/chroot.sh

##************************** chrooting *************************************##
echo -e "${MSGCOLOUR}Chrooting into arch installation...${NC}"
arch-chroot /mnt /bin/sh -c "su - -c ./chroot.sh"