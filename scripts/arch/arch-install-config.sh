#!bin\sh

# Coloured output

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'

# Parameters

drive="sdb"                # DRIVE NAME
encrypted="YES"            # YES | NO
kernel="linux-lts"         # KERNEL NAME
system="UEFI"              # UEFI | BIOS
microcode="intel-ucode"    # MICROCODE
locale="en_GB"             # LOCALE
mnt="/mnt"                 # MOUNT POINT
efimnt="/boot/efi"         # IF UEFI, EFI MOUNT POINT
region="Europe"            # REGION
city="London"              # CITY
hostname="arch-pc"         # HOSTNAME
host="
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"

user="user"
usergroup="wheel"
desktop="gnome"            # DE CHOICE (E.G. KDE)

