local m = {
    "ingenarel/smart-term.nvim",
    config = function()
        require("smart-term").setup { heightPercentage = 70, widthPercentage = 80, floatTmuxYoffset = 2 }
        require("plugins.smart-term.keybinds")
    end,
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/smart-term.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/smart-term.nvim"
end

return m
