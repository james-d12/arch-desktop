#!/usr/bin/env bash

#**************************** GET IF SSD ************************#
PS3='Is Drive SSD? '
options=("YES" "NO")
select o  in "${options[@]}"; do
    case $o in
        "YES") ssd=$o; break;;
        "NO") ssd=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET IF ENCRYPT ************************#
PS3='Encrypt Drive? '
options=("YES" "NO")
select o  in "${options[@]}"; do
    case $o in
        "YES") encrypted=$o; break;;
        "NO") encrypted=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET SWAP SIZE (ENCRYPTED) ************************#
if [ "$encrypted" == "YES" ]; then
    while [ -z $encryptedswapsize ]; do
        echo -n "Enter Encrypted Swap Size(MB): "; 
        read encryptedswapsize
    done
fi

#**************************** GET DRIVE NAME ************************#
while [ -z $drive ]; do
    echo -n "Enter Drive Name: "; 
    read drive
done

#**************************** GET SYSTEM TYPE ************************#
PS3='Choose System: '
options=("BIOS" "UEFI")
select o  in "${options[@]}"; do
    case $o in
        "BIOS") system=$o; break;;
        "UEFI") system=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET KERNEL TYPE ************************#
PS3='Choose Kernel: '
options=("linux" "linux-lts" "linux-hardened")
select o in "${options[@]}"; do
    case $o in
        "linux") kernel=$o; break;;
        "linux-lts") kernel=$o; break;;
        "linux-hardened") kernel=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET MICROCODE ************************#
PS3='Choose Microcode: '
options=("intel-ucode" "amd-ucode")
select o in "${options[@]}"; do
    case $o in
        "intel-ucode") microcode=$o; break;;
        "amd-ucode") microcode=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET DESKTOP ************************#
PS3='Choose Desktop Environment: '
options=(
    "gnome" "gnome-minimal" 
    "kde" "kde-minimal"
    "xfce" "xfce-minimal"
    "custom" "NONE"
)
select o in "${options[@]}"; do
    case $o in
        "gnome") desktopenvironment=$o; break;;
        "gnome-minimal") desktopenvironment=$o; break;;
        "kde") desktopenvironment=$o; break;;
        "kde-minimal") desktopenvironment=$o; break;;
        "xfce") desktopenvironment=$o; break;;
        "xfce-minimal") desktopenvironment=$o; break;;
        "custom") desktopenvironment=$o; break;;
        "NONE") desktopenvironment=""; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET USERNAME ************************#
while [ -z $username ]; do
    echo -n "Enter Username: "; 
    read username
done
username=$(echo "$username" | awk '{print tolower($0)}')

#**************************** GET LOCALE ************************#
PS3='Choose Locale: '
options=("en_GB" "en_US")
select o in "${options[@]}"; do
    case $o in
        "en_GB") locale=$o; break;;
        "en_US") locale=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET REGION ************************#
PS3='Choose Region: '
options=("Europe")
select o in "${options[@]}"; do
    case $o in
        "Europe") region=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET CITY ************************#
PS3='Choose City: '
options=("London")
select o in "${options[@]}"; do
    case $o in
        "London") city=$o; break;;
        *) echo "Invalid option $REPLY";;
    esac
done

#**************************** GET HOSTNAME ************************#
while [ -z $hostname ]; do
    echo -n "Enter Hostname: "; 
    read hostname
done
hostname=$(echo "$hostname" | awk '{print tolower($0)}')
host="\n127.0.0.1	localhost\n::1		localhost\n127.0.1.1	$hostname.localdomain   $hostname"

#**************************** OUTPUT TO CONFIG FILE ************************#
rm -rf arch-config.sh
touch arch-config.sh

echo "#!/usr/bin/env bash
MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'" >> arch-config.sh

echo -e "
drive="'"'${drive}'"'"
ssd="'"'${ssd}'"'"
encrypted="'"'${encrypted}'"'"
encryptedswapsize="'"'${encryptedswapsize}'"'"
system="'"'${system}'"'" 
kernel="'"'${kernel}'"'"
microcode="'"'${microcode}'"'"
desktopenvironment="'"'${desktopenvironment}'"'"
user="'"'${username}'"'"
locale="'"'${locale}'"'"
region="'"'${region}'"'"
city="'"'${city}'"'"
hostname="'"'${hostname}'"'"
host="'"'${host}'"'"
" >> arch-config.sh 

. ./arch-config.sh

#************************** Formatting and Mounting drives *************************************##

# BIOS SYSTEM
if [ "$system" == "BIOS" ]; then
    if [ "$encrypted" == "YES" ]; then
        echo -e "${MSGCOLOUR}Setting up cryptsetup...${NC}"
        modprobe dm-crypt
        modprobe dm-mod
        cryptsetup luksFormat -v -s 512 -h sha512 /dev/"${drive}2"
        cryptsetup open /dev/"${drive}2" cr_root

        echo -e "${MSGCOLOUR}Formatting encrypted install partitions...${NC}"
        mkfs.ext4 -L BOOT /dev/"${drive}1"
        mkfs.ext4 /dev/mapper/cr_root

        echo -e "${MSGCOLOUR}Mounting encrypted install partitions...${NC}"
        mount /dev/mapper/cr_root /mnt
        mkdir /mnt/boot
        mount /dev/"${drive}1" /mnt/boot
    else
        echo -e "${MSGCOLOUR}Formatting install partitions...${NC}"
        mkswap -L SWAP /dev/"${drive}1"
        mkfs.ext4 -L ROOT /dev/"${drive}2"
        
        echo -e "${MSGCOLOUR}Mounting install partitions...${NC}"
        swapon /dev/"${drive}1"
        mount /dev/"${drive}2" /mnt
    fi
# UEFI System
else 
    if [ "$encrypted" == "YES" ]; then
        echo -e "${MSGCOLOUR}Setting up cryptsetup...${NC}"
        modprobe dm-crypt
        modprobe dm-mod
        cryptsetup luksFormat -v -s 512 -h sha512 /dev/"${drive}3"
        cryptsetup open /dev/"${drive}3" cr_root

        echo -e "${MSGCOLOUR}Formatting encrypted install partitions...${NC}"
        mkfs.fat -F32 /dev/"${drive}1"
        mkfs.ext4 -L BOOT /dev/"${drive}2"
        mkfs.ext4 -L ROOT /dev/mapper/cr_root

        echo -e "${MSGCOLOUR}Mounting encrypted install partitions...${NC}"
        mount /dev/mapper/cr_root /mnt
        mkdir -p /mnt/boot
        mount /dev/"${drive}2" /mnt/boot
        mkdir -p /mnt/boot/efi
        mount /dev/"${drive}1" /mnt/boot/efi
    else
        echo -e "${MSGCOLOUR}Formatting install partitions...${NC}"
        mkfs.fat -F32 /dev/"${drive}1"
        mkswap -L SWAP /dev/"${drive}2"
        mkfs.ext4 -L ROOT /dev/"${drive}3"

        echo -e "${MSGCOLOUR}Mounting install partitions...${NC}"
        swapon /dev/"${drive}2"
        mount /dev/"${drive}3" /mnt
        mkdir -p /mnt/boot 
        mkdir -p /mnt/boot/efi
        mount /dev/"${drive}1" /mnt/boot/efi
    fi
fi


#************************** Installing Core Packages *************************************##
echo -e "${MSGCOLOUR}Preparing to install core packages...${NC}"
pacstrap /mnt base base-devel $kernel linux-firmware nano
1
##************************** fstab file *************************************##
echo -e "${MSGCOLOUR}Generating fstab file....${NC}"
genfstab -U /mnt >> /mnt/etc/fstab

echo -e "${MSGCOLOUR}Copying scripts to /mnt point....${NC}"
mkdir -p /mnt/arch-install-scripts/
cp -r * /mnt/arch-install-scripts/

##************************** chroot *************************************##
echo -e "${MSGCOLOUR}Chrooting into /mnt point....${NC}"
arch-chroot /mnt /bin/bash -c "bash arch-install-scripts/arch-install-02.sh"
