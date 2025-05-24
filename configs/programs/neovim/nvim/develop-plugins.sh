#!/usr/bin/env bash

[[ $HOME == "/root" ]] && HOME="/home/ingenarel"

changeURL(){
    if ! grep -qE 'url = git@gitlab.com:ingenarel' "$1"; then
        sed -i -E 's/url = https:\/\/github.com\/ingenarel(.+)/url = git@github.com:ingenarel\1\n\turl = git@gitlab.com:ingenarel\1/' "$1"
    fi
}

if [[ ! -d "$HOME/coding/git" ]]; then
    mkdir --parents "$HOME/coding/git"
fi

git clone https://github.com/ingenarel/metapack.nvim.git "$HOME/coding/git/metapack.nvim" || git -C "$HOME/coding/git/metapack.nvim" pull
git -C "$HOME/coding/git/metapack.nvim" switch dev
changeURL "$HOME/coding/git/metapack.nvim/.git/config"

git clone https://github.com/ingenarel/luix.nvim.git "$HOME/coding/git/luix.nvim" || git -C "$HOME/coding/git/luix.nvim" pull
changeURL "$HOME/coding/git/luix.nvim/.git/config"

git clone https://github.com/ingenarel/luse.nvim.git "$HOME/coding/git/luse.nvim" || git -C "$HOME/coding/git/luse.nvim" pull
changeURL "$HOME/coding/git/luse.nvim/.git/config"

git clone https://github.com/ingenarel/smart-term.nvim.git "$HOME/coding/git/smart-term.nvim" || git -C "$HOME/coding/git/smart-term.nvim" pull
changeURL  "$HOME/coding/git/smart-term.nvim/.git/config"

git clone https://github.com/ingenarel/simple-runner.nvim.git "$HOME/coding/git/simple-runner.nvim" || git -C "$HOME/coding/git/simple-runner.nvim" pull
changeURL  "$HOME/coding/git/simple-runner.nvim/.git/config"

git clone https://github.com/ingenarel/focus-mode.nvim.git "$HOME/coding/git/focus-mode.nvim" || git -C "$HOME/coding/git/focus-mode.nvim" pull
changeURL "$HOME/coding/git/focus-mode.nvim/.git/config"

git clone https://github.com/ingenarel/cyberpunk-neon.nvim.git "$HOME/coding/git/cyberpunk-neon.nvim" || git -C "$HOME/coding/git/cyberpunk-neon.nvim" pull
changeURL "$HOME/coding/git/cyberpunk-neon.nvim/.git/config"

git clone https://github.com/ingenarel/randomtips-nvim.git "$HOME/coding/git/randomtips-nvim" || git -C "$HOME/coding/git/randomtips-nvim" pull
changeURL "$HOME/coding/git/randomtips-nvim/.git/config"

git clone https://github.com/ingenarel/nvim-pairMan.git "$HOME/coding/git/nvim-pairMan" || git -C "$HOME/coding/git/nvim-pairMan" pull
changeURL "$HOME/coding/git/nvim-pairMan/.git/config"
