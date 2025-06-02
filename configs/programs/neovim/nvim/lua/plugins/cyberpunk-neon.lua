local m = {
    "ingenarel/cyberpunk-neon.nvim",
    config = function()
        vim.cmd.colorscheme("cyberpunk-neon")
    end,
}

if
    vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/cyberpunk-neon.nvim")) ~= nil
then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/cyberpunk-neon.nvim"
end

return m
