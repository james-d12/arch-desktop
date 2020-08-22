#!bin\bash

pippackages=(
    'selenium'          # Python Library For Web Engine Automation
    'PyQt5'             # Python wrapper of QT UI Library
    'numpy'             # Python Math Library
    'matplotlib'        # Python Graph Plotting Library
    'gym'               # Comparing reinforcement learning algorithms.
    'opencv-python'     # Library for Real Time Applications
    'pandas'            # Data Anaylsis Tool
)

for pkg in "${pippackages[@]}"; do
    pip install "$pkg" 
done