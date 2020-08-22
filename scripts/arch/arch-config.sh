#!bin\bash


#**************************** Parameters ************************#

## Desktop Environment Parameters

desktopenvironment="gnome-minimal"   
# SELECT DESKTOP ENVIRONMENT, OPTIONS ARE:
# - gnome                   | Installs the Gnome group package.
# - gnome-minimal           | Install Gnome with a minimal set of applications
# - kde                     | Installs KDE plasma packages
# - custom                  | Set specific desktop packages yourself such as window manager or group not listed

## Drive Parameters

ssd='NO'                   # IS DRIVE SSD? YES | NO          
drive="sda"                # DRIVE NAME
mnt="/mnt"                 # MOUNT POINT
efimnt="/boot/efi"         # IF UEFI, EFI MOUNT POINT
encrypted="NO"             # YES | NO
encryptedname="cr_root"    # Encrypted drive name
encryptedswapsize="4096"   # Encrypted SWAP size (MB)

## System Parameters

kernel="linux-lts"         # KERNEL NAME
microcode="intel-ucode"    # MICROCODE (amd/intel-ucode)
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

user="user"                # NAME OF USER (MUST BE LOWERCASE)
usergroup="wheel"          # GROUP FOR USER (MUST BE LOWERCASE)

# Coloured output

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'
