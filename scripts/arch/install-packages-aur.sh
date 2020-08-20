#!bin\sh

mkdir temp
cd temp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay -S --needed - < pkgaurlist.txt