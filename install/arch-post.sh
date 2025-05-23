#!/usr/bin/env bash

systemctl enable NetworkManager

timedatectl set-timezone Asia/Dhaka

sed -iE 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "ArchLinuxBaby" > /etc/hostname
passwd
passwd ingenarel
[[ -z $2 || $2 == "mbr" ]] &&\
    grub-install --target=i386-pc "/dev/$1" &&\
    grub-mkconfig -o /boot/grub/grub.cfg

shitboxDir="/home/ingenarel/.config/shitbox"
git clone https://github.com/ingenarel/shitbox "$shitboxDir"
"$shitboxDir/configs/setup.sh"
fastfetch
