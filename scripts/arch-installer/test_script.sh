#!/bin/bash

. ./arch-config.sh

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

echo "Encryption:           $encrypted"
echo "System:               $system"
echo "Kernel:               $kernel"
echo "Microcode:            $microcode"
echo "Desktop Environment:  $desktopenvironment"

echo "Username:             $username"
echo "Locale:               $locale"
echo "Region:               $region"
echo "City:                 $city"
echo "Hostname:             $hostname"
