#!bin\bash

packages=(
    #*********** SYSTEM/DRIVER SETUP ************#
    'nvidia-lts'

    #*********** DESKTOP SETUP ************#
    'gnome'
    'gnome-tweaks'

    #*********** SYSTEM TOOLS SETUP ************#
    'make'
    'cmake'
    'git'

    #*********** PROGRAMMING LANGUAGE SETUP ************#
    'gcc'   
    'gdb'
    'clang'
    'cppcheck'
    'nodejs'
    'rust'
    'ghc'
    'jdk-openjdk'
    'dotnet-sdk'
    'python-pip'

    #*********** UTILITY APPLICATIONS SETUP ************#
    'ufw'
    'firejail'
    'apparmor'
    'grub-customizer'
    'gparted'

    #*********** APPLICATIONS SETUP ************#
    'firefox'
    'chromium'
    'code'
    'discord'
    'vlc'
    'obs-studio'
    'gimp'
    'flameshot'
    'feedreader'
    'youtube-dl'
    'virtualbox'
    'virtualbox-host-dkms'
)

sudo pacman -S --needed --noconfirm - < ${packages[@]}
