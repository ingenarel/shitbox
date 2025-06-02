local m = {
    "ingenarel/luix.nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/luix.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/luix.nvim"
end

return m
