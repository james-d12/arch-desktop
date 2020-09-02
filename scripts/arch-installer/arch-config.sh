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

drive="sda"                # DRIVE NAME
encryptedswapsize="4096"   # IF ENCRYPTION: Encrypted SWAP size (MB)
ssd='NO'                   # IS DRIVE SSD? YES | NO          

system=""              
encrypted=""             
kernel=""         
microcode=""    
user=""                
locale=""            
region=""            
city=""              
hostname=""         

# predefined parameters DO NOT CHANGE!
MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'
host="                     
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"
