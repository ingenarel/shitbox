local m = {
    "ingenarel/flex-stats.nvim",
    opts = {},
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/flex-stats.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/flex-stats.nvim"
end

return m
