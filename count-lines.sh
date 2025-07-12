#!/usr/bin/env bash

shitboxLines=0
for file in $(git -C "$HOME/.config/shitbox" ls-files); do
    file --mime-type "$file" | grep -qE ".+ text/.+" && {
        shitboxLines="$(( "$shitboxLines" + "$( wc -l "$file" | grep -oE "^[0-9]+")" ))"
    }
done
echo "Project shitbox lines (excluding submodules) = $shitboxLines"

neovimLines=0
for file in $(find "$HOME/.config/shitbox/configs/programs/neovim/nvim/"); do
    file --mime-type "$file" | grep -qE ".+ text/.+" && {
        neovimLines="$(( "$neovimLines" + "$( wc -l "$file" | grep -oE "^[0-9]+")" ))"
    }
done
echo "Neovim config lines = $neovimLines"

neovimPluginLines=0
for file in $(find "$HOME/.config/shitbox/configs/programs/neovim/myPlugins/"); do
    file --mime-type "$file" | grep -qE ".+ text/.+" && {
        neovimPluginLines="$(( "$neovimPluginLines" + "$( wc -l "$file" | grep -oE "^[0-9]+")" ))"
    }
done
echo "My neovim plugin lines = $neovimPluginLines"

totalLines=0
for file in $(find "$HOME/.config/shitbox/"); do
    file --mime-type "$file" | grep -qE ".+ text/.+" && {
        totalLines="$(( "$totalLines" + "$( wc -l "$file" | grep -oE "^[0-9]+")" ))"
    }
done
echo "Project shitbox lines (everything including submodules) = $totalLines"
