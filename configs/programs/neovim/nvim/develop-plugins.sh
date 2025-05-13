#!/usr/bin/env bash

if [[ ! -d "$HOME/coding/git" ]]; then
    mkdir --parents "$HOME/coding/git"
fi

git clone git@github.com:ingenarel/metapack.nvim "$HOME/coding/git/metapack.nvim"
git -C "$HOME/coding/git/metapack.nvim" switch dev
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/metapack.nvim/.git/config"

git clone git@github.com:ingenarel/luix.nvim "$HOME/coding/git/luix.nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/luix.nvim/.git/config"

git clone git@github.com:ingenarel/smart-term.nvim "$HOME/coding/git/smart-term.nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/'  "$HOME/coding/git/smart-term.nvim/.git/config"

git clone git@github.com:ingenarel/simple-runner.nvim "$HOME/coding/git/simple-runner.nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/'  "$HOME/coding/git/simple-runner.nvim/.git/config"

git clone git@github.com:ingenarel/focus-mode.nvim "$HOME/coding/git/focus-mode.nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/focus-mode.nvim/.git/config"

git clone git@github.com:ingenarel/cyberpunk-neon.nvim "$HOME/coding/git/cyberpunk-neon.nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/cyberpunk-neon.nvim/.git/config"

git clone git@github.com:ingenarel/randomtips-nvim "$HOME/coding/git/randomtips-nvim"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/randomtips-nvim/.git/config"

git clone git@github.com:ingenarel/nvim-pairMan "$HOME/coding/git/nvim-pairMan"
sed -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$HOME/coding/git/nvim-pairMan/.git/config"
