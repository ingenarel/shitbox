local m = {
    "ingenarel/nvim-pairMan",
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/nvim-pairMan")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/nvim-pairMan"
end

return m
