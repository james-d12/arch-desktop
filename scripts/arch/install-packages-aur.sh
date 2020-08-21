#!bin\sh

mkdir -p temp
cd temp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay -S --noconfirm - < pkgaurlist.txt