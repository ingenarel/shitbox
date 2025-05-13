#!/usr/bin/env bash

if [[ ! -d "$HOME/coding/git" ]]; then
    mkdir --parents "$HOME/coding/git"
fi

git clone git@github.com:ingenarel/metapack.nvim "$HOME/coding/git/metapack.nvim"
git clone git@github.com:ingenarel/luix.nvim "$HOME/coding/git/luix.nvim"
git clone git@github.com:ingenarel/smart-term.nvim "$HOME/coding/git/smart-term.nvim"
git clone git@github.com:ingenarel/simple-runner.nvim "$HOME/coding/git/simple-runner.nvim"
git clone git@github.com:ingenarel/focus-mode.nvim "$HOME/coding/git/focus-mode.nvim"
git clone git@github.com:ingenarel/cyberpunk-neon.nvim "$HOME/coding/git/cyberpunk-neon.nvim"
git clone git@github.com:ingenarel/randomtips-nvim "$HOME/coding/git/randomtips-nvim"
git clone git@github.com:ingenarel/nvim-pairMan "$HOME/coding/git/nvim-pairMan"
