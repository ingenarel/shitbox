local m = {
    "ingenarel/luse.nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/luse.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/luse.nvim"
end

return m
