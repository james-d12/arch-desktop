#!bin\bash

packages=(
    'selenium'          # Python Library For Web Engine Automation
    'PyQt5'             # Python wrapper of QT UI Library
    'numpy'             # Python Math Library
    'matplotlib'        # Python Graph Plotting Library
)

for pkg in "${packages[@]}"; do
    pip install "$pkg" 
done