#!bin\sh

# Coloured output

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'

#**************************** Parameters ************************#

## Drive Parameters

drive="sdb"                # DRIVE NAME
mnt="/mnt"                 # MOUNT POINT
efimnt="/boot/efi"         # IF UEFI, EFI MOUNT POINT
encrypted="YES"            # YES | NO]
encryptedname="cr_root"    # Encrypted drive name
encryptedswapsize="4096"   # Encrypted SWAP size

## System Parameters

kernel="linux-lts"         # KERNEL NAME
microcode="intel-ucode"    # MICROCODE
system="UEFI"              # UEFI | BIOS

## Locale and Network Parameters

locale="en_GB"             # LOCALE
region="Europe"            # REGION
city="London"              # CITY
hostname="arch-pc"         # HOSTNAME
host="
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"

## Other Parameters

user="user"
usergroup="wheel"

