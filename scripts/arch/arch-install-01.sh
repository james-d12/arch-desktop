#!bin\sh

. ./arch-install-config.sh

#************************** Formatting and Mounting drives *************************************##

if [ $encrypted == "YES" ]; then
    echo -e "${MSGCOLOUR}Setting up cryptsetup...${NC}"
    modprobe dm-crypt
    modprobe dm-mod
    cryptsetup luksFormat -v -s 512 -h sha512 /dev/"${drive}3"
    cryptsetup open /dev/"${drive}3" $encryptedname

    echo -e "${MSGCOLOUR}Formatting encrypted install partitions...${NC}"
    mkfs.fat -F32 /dev/"${drive}1"
    mkfs.ext4 /dev/"${drive}2"
    mkfs.ext4 /dev/mapper/$encryptedname

    echo -e "${MSGCOLOUR}Mounting encrypted install partitions...${NC}"
    mount /dev/mapper/$encryptedname $mnt
    mkdir -p $mnt/boot
    mount /dev/"${drive}2" $mnt/boot
    mkdir -p $mnt$efimnt
    mount /dev/"${drive}1" $mnt$efimnt
else
    echo -e "${MSGCOLOUR}Formatting install partitions...${NC}"
    mkfs.fat -F32 /dev/"${drive}1"
    mkswap -L SWAP /dev/"${drive}2"
    mkfs.ext4 -L ROOT /dev/"${drive}3"

    echo -e "${MSGCOLOUR}Mounting install partitions...${NC}"
    swapon /dev/"${drive}2"
    mkdir -p $mnt/boot 
    mkdir -p $mnt$efimnt
    mount /dev/"${drive}1" $mnt$efimnt
    mount /dev/"${drive}3" $mnt
fi

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
echo -e "${MSGCOLOUR}Chrooting into $mnt point....${NC}"
echo -e "${MSGCOLOUR}Run the 'arch-install-02.sh' command in the directory 'arch-install-scripts/'....${NC}"
arch-chroot $mnt