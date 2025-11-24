#!/usr/bin/sh

sync
sleep 1
sync

sudo emerge --ask n --oneshot genfstab

{
    genfstab -U / | sudo tee --append /etc/fstab &&\
        echo "/swapFile none swap defaults" | sudo tee --append /etc/fstab &&\
        echo "Generated fstab"
    } || {
    echo "generating fstab failed"
    exit 1
}

sudo systemctl enable NetworkManager &&
echo "Enabled NetworkManager"

[ "$HOST_NAME" = "gentoo-vm-tui" ] && {
    sudo systemctl enable sshd &&
    echo "Enabled sshd"
}

echo "$HOST_NAME" | sudo tee /etc/hostname && echo "Generated hostname"

if [ "$BOOT_TYPE" = "dos" ]; then
    echo "Installing grub"
    sudo grub-install --target=i386-pc "/dev/$DEVICE_NAME" && {
        echo "Installed grub"
        echo "Generating grub config"
        sudo grub-mkconfig -o /boot/grub/grub.cfg &&\
            echo "Generated grub config"
    } ||
    {
        echo "grub install failed"
        exit 1
    }
fi

shitboxDir="/home/ingenarel/.config/shitbox"
git clone --recursive https://github.com/ingenarel/shitbox "$shitboxDir"
"$shitboxDir/configs/setup.sh"

sudo eselect repository remove -f gentoo
sudo rm -rf /var/db/repos/gentoo
sudo eselect repository add gentoo git https://github.com/gentoo-mirror/gentoo.git

sudo eselect repository enable guru

sudo emerge --sync

"$shitboxDir/ensureInstalled/gentoo.sh"
command -v zsh && zsh -c "source ~/.zshrc"
# disable for now until i find a way to launch metapack properly in the correct env
# command -v nvim && nvim
