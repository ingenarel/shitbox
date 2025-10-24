local m = {
    "ingenarel/zoxide.nvim",
    opts = {},
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/zoxide.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/zoxide.nvim"
end

return m
