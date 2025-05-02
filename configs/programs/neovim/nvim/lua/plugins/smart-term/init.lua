local m = {
    "ingenarel/smart-term.nvim",
    config = function()
        require("smart-term").setup { heightPercentage = 70, widthPercentage = 80 }
        require("plugins.smart-term.keybinds")
    end,
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/smart-term.nvim")) ~= nil then
    m.dir = "~/coding/git/smart-term.nvim"
end

return m
