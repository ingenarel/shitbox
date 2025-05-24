#!/usr/bin/env bash

[[ $HOME == "/root" ]] && HOME="/home/ingenarel"

addGitlabURL(){
    if ! grep -qE 'url = git@gitlab.com:ingenarel' "$1"; then
        sed -i -E 's/url = git@github.com:ingenarel\/(.+)/&\n\turl = git@gitlab.com:ingenarel\/\1/' "$1"
    fi
}

if [[ ! -d "$HOME/coding/git" ]]; then
    mkdir --parents "$HOME/coding/git"
fi

git clone git@github.com:ingenarel/metapack.nvim "$HOME/coding/git/metapack.nvim" || git -C "$HOME/coding/git/metapack.nvim" pull
git -C "$HOME/coding/git/metapack.nvim" switch dev
addGitlabURL "$HOME/coding/git/metapack.nvim/.git/config"

git clone git@github.com:ingenarel/luix.nvim "$HOME/coding/git/luix.nvim" || git -C "$HOME/coding/git/luix.nvim" pull
addGitlabURL "$HOME/coding/git/luix.nvim/.git/config"

git clone git@github.com:ingenarel/luse.nvim "$HOME/coding/git/luse.nvim" || git -C "$HOME/coding/git/luse.nvim" pull
addGitlabURL "$HOME/coding/git/luse.nvim/.git/config"

git clone git@github.com:ingenarel/smart-term.nvim "$HOME/coding/git/smart-term.nvim" || git -C "$HOME/coding/git/smart-term.nvim" pull
addGitlabURL  "$HOME/coding/git/smart-term.nvim/.git/config"

git clone git@github.com:ingenarel/simple-runner.nvim "$HOME/coding/git/simple-runner.nvim" || git -C "$HOME/coding/git/simple-runner.nvim" pull
addGitlabURL  "$HOME/coding/git/simple-runner.nvim/.git/config"

git clone git@github.com:ingenarel/focus-mode.nvim "$HOME/coding/git/focus-mode.nvim" || git -C "$HOME/coding/git/focus-mode.nvim" pull
addGitlabURL "$HOME/coding/git/focus-mode.nvim/.git/config"

git clone git@github.com:ingenarel/cyberpunk-neon.nvim "$HOME/coding/git/cyberpunk-neon.nvim" || git -C "$HOME/coding/git/cyberpunk-neon.nvim" pull
addGitlabURL "$HOME/coding/git/cyberpunk-neon.nvim/.git/config"

git clone git@github.com:ingenarel/randomtips-nvim "$HOME/coding/git/randomtips-nvim" || git -C "$HOME/coding/git/randomtips-nvim" pull
addGitlabURL "$HOME/coding/git/randomtips-nvim/.git/config"

git clone git@github.com:ingenarel/nvim-pairMan "$HOME/coding/git/nvim-pairMan" || git -C "$HOME/coding/git/nvim-pairMan" pull
addGitlabURL "$HOME/coding/git/nvim-pairMan/.git/config"
