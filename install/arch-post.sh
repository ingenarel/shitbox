#!/usr/bin/env bash

echo "Enabling NetworkManager" && systemctl enable NetworkManager && echo "Enabled NetworkManager"

echo "Setting timezone to Asia/Dhaka" && timedatectl set-timezone Asia/Dhaka && echo "Set timezone to Asia/Dhaka"

echo "generating locales"
sed -iE 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "Generated locales"

echo "ArchLinuxBaby" > /etc/hostname && echo "Generated hostname"

setRootPassword(){
    echo "enter the password for root"
    passwd || setRootPassword
}
setRootPassword

setUserPassword(){
    echo "enter the password for ingenarel"
    passwd ingenarel || setUserPassword
}
setUserPassword

[[ -z $2 || $2 == "mbr" ]] &&\
    echo "Installing grub" && grub-install --target=i386-pc "/dev/$1" && echo "Installed grub" &&\
    echo "Generating grub config" && grub-mkconfig -o /boot/grub/grub.cfg && echo "Generated grub config"

shitboxDir="/home/ingenarel/.config/shitbox"
git clone https://github.com/ingenarel/shitbox "$shitboxDir"
"$shitboxDir/configs/setup.sh"

echo "installing paru-git"
git clone https://aur.archlinux.org/paru-git.git /tmp/paru
cd /tmp/paru && makepkg -si
echo "installed paru-git"
