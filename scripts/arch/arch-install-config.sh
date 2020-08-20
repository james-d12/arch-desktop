#!bin\sh

MSGCOLOUR='\033[0;33m'
PROMPTCOLOUR='\033[0;32m'
NC='\033[0m'

# Parameters

kernel="linux-lts"
microcode="intel-ucode"
locale="en_GB"
mnt="/mnt"
efimnt="/boot/efi"
region="Europe"
city="London"
hostname="arch-pc"
host="
127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostname.localdomain   $hostname"

user="user"
