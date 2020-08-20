#!bin\sh

. ./arch-install-config.sh

#************************** Formatting and Mounting drives *************************************##

mkfs.fat -F32 /dev/$drive1
mkswap -L SWAP /dev/$drive2
swapon /dev/$drive2
mkfs.ext4 -L ROOT /dev/$drive3
mkdir -p $mnt/$efimnt
mount /dev/$drive1 $mnt/$efimnt
mount /dev/$drive3 $mnt

#************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap $mnt base base-devel $kernel linux-firmware nano

##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U $mnt >> $mnt/etc/fstab

echo -e "${MSGCOLOUR}Copying scripts to $mnt point....${NC}"
mkdir -p $mnt/arch-install-scripts/
cp * $mnt/arch-install-scripts/

##************************** chroot *************************************##
arch-chroot $mnt