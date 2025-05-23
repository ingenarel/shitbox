#!/usr/bin/env bash

sync
sleep 1

echo "Enabling NetworkManager" && sudo systemctl enable NetworkManager && echo "Enabled NetworkManager"

echo "Setting timezone to Asia/Dhaka" && sudo timedatectl set-timezone Asia/Dhaka && echo "Set timezone to Asia/Dhaka"

echo "generating locales"
sudo sed -iE 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
echo "Generated locales"

echo "ArchLinuxBaby" | sudo tee /etc/hostname && echo "Generated hostname"

[[ -z $2 || $2 == "mbr" ]] &&\
    echo "Installing grub" && sudo grub-install --target=i386-pc "/dev/$1" && echo "Installed grub" &&\
    echo "Generating grub config" && sudo grub-mkconfig -o /boot/grub/grub.cfg && echo "Generated grub config"

shitboxDir="/home/ingenarel/.config/shitbox"
git clone https://github.com/ingenarel/shitbox "$shitboxDir"
"$shitboxDir/configs/setup.sh"

echo "installing paru-git"
git clone https://aur.archlinux.org/paru-git.git /tmp/paru
cd /tmp/paru && makepkg -si
echo "installed paru-git"
