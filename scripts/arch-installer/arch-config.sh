#!/usr/bin/env bash

#**************************** Parameters ************************#

## Desktop Environment Parameters

desktopenvironment="gnome-minimal"   
# SELECT DESKTOP ENVIRONMENT, OPTIONS ARE:
# - gnome                   | Installs the Gnome group package.
# - gnome-minimal           | Install Gnome with a minimal set of applications
# - kde                     | Installs KDE plasma packages
# - kde-minimal             | Installs KDE plasma with a minimal set of packages
# - xfce                    | Installs XFCE DE and packages.
# - xfce-minimal            | Installs XFCE DE with a minimal set of packages
# - custom                  | Installs custom DE and packages
# - (empty)                 | If string is empty will not install any Desktop Environment.

## Drive Parameters

ssd='NO'                   # IS DRIVE SSD? YES | NO          
drive="sda"                # DRIVE NAME
efimnt="/boot/efi"         # IF UEFI, EFI MOUNT POINT
encrypted="NO"             # DO YOU WANT ENCRYPTION? YES | NO
encryptedname="cr_root"    # Encrypted drive name
encryptedswapsize="4096"   # Encrypted SWAP size (MB)

kernel="linux-lts"         # KERNEL NAME
microcode="intel-ucode"    # MICROCODE (amd/intel-ucode)
system="UEFI"              # UEFI | BIOS
 
locale="en_GB"             # LOCALE - E.G. en_GB = British English 
region="Europe"            # REGION
city="London"              # CITY
hostname="arch-pc"         # HOSTNAME

user="user"                # NAME OF USER (MUST BE LOWERCASE)
usergroup="wheel"          # GROUP FOR USER (MUST BE LOWERCASE)


# predefined parameters DO NOT CHANGE!

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'
host="                     
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"
