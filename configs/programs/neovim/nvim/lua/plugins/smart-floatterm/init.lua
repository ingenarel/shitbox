local m = {
    "ingenarel/smart-floatterm.nvim",
    config = function()
        require("smart-floatterm").setup { heightPercentage = 70, widthPercentage = 80 }
        require("plugins.smart-floatterm.keybinds")
    end,
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/smart-floatterm.nvim")) ~= nil then
    m.dir = "~/coding/git/smart-floatterm.nvim"
end

return m
