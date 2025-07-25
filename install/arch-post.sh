#!/usr/bin/env bash

sync
sleep 1

echo "Enabling NetworkManager" && sudo systemctl enable NetworkManager && echo "Enabled NetworkManager"

echo "Setting timezone to Asia/Dhaka" && sudo ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime && echo "Set timezone to Asia/Dhaka"

sudo dmidecode -s system-manufacturer | grep -qEi 'qemu' && sudo systemctl enable sshd && echo "Enabled sshd"

echo "generating locales"
sudo sed -iE 's/#\s*en_US.UTF-8\s*UTF-8/en_US.UTF-8 UTF-8/I' /etc/locale.gen
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

aurHelper="paru"

[[ $(( $(grep --extended-regexp 'MemTotal' /proc/meminfo | sed --expression='s/[^0-9]//g') / (1000 * 1000) )) -lt 8 ]] && aurHelper="paru-bin"

echo "installing $aurHelper"
git clone https://aur.archlinux.org/$aurHelper.git /tmp/paru
cd /tmp/paru && makepkg -si
echo "installed $aurHelper"
"$shitboxDir/ensureInstalled/arch.sh"
command -v zsh && zsh -c "source ~/.zshrc"
command -v nvim && nvim --headless
