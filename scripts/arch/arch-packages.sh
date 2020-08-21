#!bin\bash

packages=(
    #*********** SYSTEM/DRIVER SETUP ************#
    'linux-lts-headers'         # Headers for LTS Kernel
    'nvidia-lts'                # Nvidia LTS Driver

    #*********** DESKTOP SETUP ************#
    'baobab'
    'eog'
    'evince'
    'file-roller'
    'gdm'
    'gnome-calculator'
    'gnome-characters'
    'gnome-color-manager'
    'gnome-control-center'
    'gnome-disk-utility'
    'gnome-keyring'
    'gnome-logs'
    'gnome-menus'
    'gnome-session'
    'gnome-settings-daemon'
    'gnome-shell'
    'gnome-shell-extensions'
    'gnome-system-monitor'
    'gnome-terminal'
    'gnome-themes-extra'
    'gnome-user-docs'
    'grilo-plugins'
    'mutter'
    'nautilus'
    'networkmanager'
    'sushi'
    'tracker'
    'tracker-miners'
    'xdg-user-dirs-gtk'
    'yelp'
    'gnome-tweaks'              

    #*********** SYSTEM TOOLS SETUP ************#
    'make'                      # Linux Build Tool
    'cmake'                     # Build Tool
    'git'                       # Software Management
    'wget'                      # File Downloader
    'curl'                      # File Downloader

    #*********** PROGRAMMING LANGUAGE SETUP ************#
    'gcc'                       # C/C++ Compiler
    'gdb'                       # C/C++ Debugger
    'clang'                     # Clang C/C++ Compiler
    'cppcheck'                  # Compile-time C++ Checker
    'nodejs'                    # Node.js
    'rust'                      # Rust Package
    'ghc'                       # Haskell Compiler
    'jdk-openjdk'               # Java SDK
    'dotnet-sdk'                # .NET SDK
    'python-pip'                # Python3 PIP

    #*********** UTILITY APPLICATIONS SETUP ************#
    'ufw'                       # Firewall
    'apparmor'                  # Security Software
    'firejail'                  # Sandboxing Software
    'grub-customizer'           # Grub Configuration
    'gparted'                   # Disk Manager

    #*********** APPLICATIONS SETUP ************#
    'firefox'                   # Firefox Browser
    'chromium'                  # Chromium Browser
    'code'                      # VSCode Editor 
    'discord'                   # Communication
    'vlc'                       # Music and Video Player
    'obs-studio'                # Recording and Streaming
    'gimp'                      # Image Editor
    'flameshot'                 # Screenshot software
    'feedreader'                # RSS Reader
    'youtube-dl'                # Youtube Downloader CL Program
    'libreoffice-still'         # Office Writer
    'virtualbox'                # Virtual Machine 
    'virtualbox-host-dkms'      # Virtual Machine Dependency for LTS kernel.
    'wireshark-qt'              # Network Analyzer
    'transmission-qt'           # BitTorrent Software
    'thunderbird'               # Email Client
    'signal-desktop'            # Signal Desktop App
)

for pkg in "${packages[@]}"; do
    sudo pacman -S "$pkg" --noconfirm --needed
done