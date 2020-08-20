#!bin\sh

. ./arch-install-config.sh

#************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap $mnt base base-devel $kernel linux-firmware nano

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U $mnt >> $mnt/etc/fstab

echo -e "${MSGCOLOUR}Copying scripts to /mnt point....${NC}"
mkdir -p /mnt/arch-install-scripts/
cp * /mnt/arch-install-scripts/