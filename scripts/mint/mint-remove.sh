#!bin/bash

packages=(
    #*********** HUNSPELL LANGUAGES ************#
    'hunspell-en-au'
    'hunspell-en-ca'
    'hunspell-fr'
    'hunspell-fr-classical'
    'hunspell-de-at-frami'
    'hunspell-de-ch-frami'
    'hunspell-de-de-frami'
    'hunspell-en-za'
    'hunspell-es'
    'hunspell-it'
    'hunspell-pt-br'
    'hunspell-pt-pt'
    'hunspell-ru'

    #*********** LIBREOFFICE LANGUAGES ************#
    'libreoffice-help-de'
    'libreoffice-help-es'
    'libreoffice-help-fr'
    'libreoffice-help-it'
    'libreoffice-help-pt'
    'libreoffice-help-pt-br'
    'libreoffice-help-ru'
    'libreoffice-help-zh-cn'
    'libreoffice-help-zh-tw'
    'libreoffice-l10n-de'
    'libreoffice-l10n-en-za'
    'libreoffice-l10n-es'
    'libreoffice-l10n-fr'
    'libreoffice-l10n-it'
    'libreoffice-l10n-pt'
    'libreoffice-l10n-pt-br'
    'libreoffice-l10n-ru'
    'libreoffice-l10n-zh-cn'
    'libreoffice-l10n-zh-tw'

    #*********** OTHER LANGUAGES ************#
    'witalian'
    'wfrench'
    'wspanish'
    'wbrazilian'
    'wswiss'
    'wngerman'
    'wogerman'
    'wportuguese'
    'hyphen-de'
    'hyphen-fr'
    'hyphen-it'
    'hyphen-pt-br'
    'hyphen-pt-pt'
    'hyphen-ru'
    'mythes-fr'
    'mythes-it'
    'mythes-pt-pt'
    'mythes-ru'
    'mythes-de'
    'mythes-de-ch'

    #*********** BLUETOOTH ************#
    'bluetooth'
    'pulseaudio-module-bluetooth'
    'bluez-tools'
    'blueberry'
    'gnome-bluetooth'
    'gir1.2-gnomebluetooth-1.0'
    'bluez'
    'bluez-obexd'
    'libgnome-bluetooth13'

    #*********** PRINTER ************#
    'printer-driver-min12xxw'
    'printer-driver-sag-gdi'
    'printer-driver-m2300w'
    'printer-driver-pxljr'
    'printer-driver-ptouch'
    'printer-driver-pnm2ppa'
    'printer-driver-splix'
    'printer-driver-postscript-hp'
    'printer-driver-brlaser'
    'printer-driver-gutenprint'
    'printer-driver-c2esp'
    'printer-driver-foo2zjs-common'
    'printer-driver-foo2zjs'
    'system-config-printer'
    'system-config-printer-common'
    'system-config-printer-udev'
    'bluez-cups'
    'hplip'
    'hplip-data'
    'printer-driver-hpcups'
    'cups'
    'cups-core-drivers'
    'cups-browsed'
    'cups-filters-core-drivers'
    'cups-pk-helper'
    'python3-cupshelpers'
    'ippusbxd'
    'openprinting-ppds'
    'libhpmud0'
    'libsane-hpaio'
    'foomatic-db-compressed-ppds'

    #*********** SOFTWARE ************#
    'hexchat'
    'hexchat-common'
    'onboard'
    'onboard-common'
    'gnote'
    'celluloid'
    'firefox'
    'firefox-locale-en'
    'simple-scan'
    'pix'
    'pix-data'
    'pix-dbg'
    'xviewer'
    'xviewer-dbg'
    'xfce4-dict'
    'xul-ext-lightning'
    'thunderbird-locale-en-us'
    'thunderbird-locale-en'
    'thunderbird-gnome-support'
    'thunderbird'
    'rhythmbox-plugins'
    'rhythmbox-data'
    'gir1.2-rb-3.0'
    'rhythmbox-plugin-tray-icon'
    'rhythmbox'
    'transmission-gtk'
    'libreoffice-base'
    'libreoffice-ogltrans'
    'libreoffice-impress'
    'libreoffice-draw'
    'libreoffice-math'
)


flags=""
case "$1" in
     "-y")
       flags="--yes --force-yes"
       ;;
     *)
       flags=""
       ;;
esac

sudo apt-get --purge remove $packages $flags 
sudo apt-get autoremove $flags
sudo apt-get clean 

sudo apt-get install deborphan $flags
orphaned=$(deborphan)
sudo apt-get $flags --purge remove $orphaned
