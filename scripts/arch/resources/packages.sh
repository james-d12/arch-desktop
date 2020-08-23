#!bin\bash

# Contains a list of packages to install.

packages=(
    #*********** SYSTEM/DRIVER SETUP ************#
    'xorg'
    'xorg-server'
    'linux-lts-headers'         # Headers for LTS Kernel
    'nvidia-lts'                # Nvidia LTS Driver

    #*********** SYSTEM TOOLS SETUP ************#
    'mtools'                    # MS-DOS Disk Tools
    'dosfstools'                # DOS Filesystem Utilities
    'os-prober'                 # Detects other OSs
    'ntfs-3g'                   # Mount and interact with NTFS drives.
    'make'                      # Linux Build Tool
    'cmake'                     # Build Tool
    'git'                       # Software Management
    'wget'                      # File Downloader
    'curl'                      # File Downloader
    'neofetch'                  # CLI Information Tool
    'hwinfo'                    # Hardware CLI tool
    'htop'                      # CLI Task Manager
    'dmidecode'                 # Interface For Memory
    'iputils'                   # Network Tools
    'traceroute'                # Packet Route Tracking
    'fail2ban'                  # IP Banner
    'parted'                    # Terminal Partitioning Tool
    'hdparm'                    # Used For Getting Disk Speeds
    'lm_sensors'                # Used For Getting Temperature Readings
    'feh'                       # CLI Image Tool
    'ffmpeg'                    # CLI Audio Tool

    #*********** PROGRAMMING LANGUAGE / DEVELOPMENT TOOLS SETUP ************#
    'nasm'                      # Assembler
    'gcc'                       # C/C++ Compiler
    'gdb'                       # C/C++ Debugger
    'clang'                     # Clang C/C++ Compiler
    'cppcheck'                  # Compile-time C++ Checker
    'nodejs'                    # Node.js
    'npm'                       # Node Package Manager
    'rust'                      # Rust Package
    'ghc'                       # Haskell Compiler
    'jdk-openjdk'               # Java SDK
    'dotnet-sdk'                # .NET SDK
    'mono'                      # Mono For C#
    'python-pip'                # Python3 PIP
    'glfw'                      # OpenGL Library
    'glew'                      # OpenGL Library

    #*********** UTILITY APPLICATIONS SETUP ************#
    'ufw'                       # Firewall
    'apparmor'                  # Security Software
    'firejail'                  # Sandboxing Software
    'grub-customizer'           # Grub Configuration
    'gparted'                   # Disk Manager

    #*********** APPLICATIONS SETUP ************#
    'firefox'                   # Firefox Browser
    'code'                      # VSCode Editor 
    'neovim'                    # Neo Vim - More plugin Support
    'discord'                   # Communication
    'vlc'                       # Music and Video Player
    'obs-studio'                # Recording and Streaming
    'gimp'                      # Image Editor
    'zathura'                   # PDF Reader
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

packages-aur=(
    'gconf'                         # Utility
    'bitwarden-bin'                 # Password Manager
    'brave-bin'                     # Privacy Focused Web Browser
    'godot'                         # Lightweight Game-Engine
    'unity-editor-lts'              # Unity3D Engine
    'zeal-git'                      # Offline Documentation Viewer
)

packages-pip=(
    'selenium'          # Python Library For Web Engine Automation
    'PyQt5'             # Python wrapper of QT UI Library
    'numpy'             # Python Math Library
    'matplotlib'        # Python Graph Plotting Library
    'gym'               # Comparing reinforcement learning algorithms.
    'opencv-python'     # Library for Real Time Applications
    'pandas'            # Data Anaylsis Tool
)