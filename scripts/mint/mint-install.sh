#!/bin/bash

flags=""
case "$1" in
     "-y")
       flags="--yes --force-yes"
       ;;
     *)
       flags=""
       ;;
esac

mkdir downloads/

## Install mulitmedia codecs
apturl apt://mint-meta-codecs?refresh=yes

## Core 
sudo apt-get install g++ $flags
sudo apt-get install git $flags
sudo apt-get install vim $flags

sudo apt-get install python-all-dev $flags
sudo apt-get install python-setuptools $flags
sudo apt-get install python-wheel $flags
sudo apt-get install python3 $flags
sudo apt-get install python3-pip $flags
sudo apt-get install python-pip $flags

## dependencies install
sudo apt install apt-transport-https curl $flags
sudo apt install ttf-mscorefonts-installer $flags

## Install .NET SDK
wget -O downloads/packages-microsoft-prod.deb https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb 
sudo dpkg -i downloads/packages-microsoft-prod.deb 
sudo apt-get update
sudo apt-get install dotnet-sdk-3.1 $flags

set DOTNET_CLI_TELEMETRY_OUTPUT=1

## Install gparted
sudo apt-get install gparted $flags

## Install gtkorphan
sudo apt-get install gtkorphan $flags

## Install youtube-dl graphic
sudo add-apt-repository ppa:nilarimogard/webupd8 
sudo apt-get update
sudo apt-get install youtube-dlg $flags

## Install bitwarden
#wget -O downloads/bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb" --header "Referer: www.bitwarden.com"
#sudo dpkg -i downloads/bitwarden.deb 
#sudo apt install --fix-broken $flags

## Install tresorit
wget -O downloads/tresorit_installer.run "https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run" --header "Referer: www.tresorit.com"
sudo chmod +x downloads/tresorit_installer.run 
sh downloads/tresorit_installer.run

## Install joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash

## Install discord
wget  -O downloads/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb" --header "Referer: www.discord.com"
sudo dpkg -i downloads/discord.deb 
sudo apt install  --fix-broken $flags

## Drivers
#sudo ubuntu-drivers autoinstall 

mkdir downloads

## Install VLC
sudo apt-get install vlc $flags

## Install brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser $flags

