#!/usr/bin/env bash

#**************************** Parameters ************************#

## Desktop Environment Parameters

## Drive Parameters

drive="sda"                # DRIVE NAME
encryptedswapsize="4096"   # IF ENCRYPTION: Encrypted SWAP size (MB)
ssd='NO'                   # IS DRIVE SSD? YES | NO          
      
# predefined parameters DO NOT CHANGE!
MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'
host="                     
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"