local m = {
    "ingenarel/randomtips-nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/randomtips-nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/randomtips-nvim"
end

return m
