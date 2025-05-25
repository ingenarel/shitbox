#!/usr/bin/env bash

sync
sleep 1

sudo emerge --ask n --oneshot genfstab

echo "Generating fstab" && genfstab -U /mnt | sudo tee /etc/fstab && echo "/swapFile none swap defaults" >> /mnt/etc/fstab && echo "Generated fstab"

echo "Enabling NetworkManager" && sudo systemctl enable NetworkManager && echo "Enabled NetworkManager"

sudo dmidecode -s system-manufacturer | grep -qEi 'qemu' && sudo systemctl enable sshd && echo "Enabled sshd"

echo "GentooBaby" | sudo tee /etc/hostname && echo "Generated hostname"

[[ -z $2 || $2 == "mbr" ]] &&\
    echo "Installing grub" && sudo grub-install --target=i386-pc "/dev/$1" && echo "Installed grub" &&\
    echo "Generating grub config" && sudo grub-mkconfig -o /boot/grub/grub.cfg && echo "Generated grub config"

shitboxDir="/home/ingenarel/.config/shitbox"
git clone https://github.com/ingenarel/shitbox "$shitboxDir"
"$shitboxDir/configs/setup.sh"

sudo eselect repository disable gentoo
sudo eselect repository enable gentoo

sudo eselect repository enable guru

emerge --sync

"$shitboxDir/ensureInstalled/arch.sh"
"$shitboxDir/configs/programs/neovim/nvim/develop-plugins.sh"
# command -v zsh && zsh -c "source ~/.zshrc"
# command -v nvim && nvim --headless
