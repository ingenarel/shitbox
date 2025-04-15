local m = {
    "ingenarel/smart-floatterm.nvim",
    opts = {
        heightPercentage = 70,
        widthPercentage = 80,
    },
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/smart-floatterm.nvim")) ~= nil then
    m.dir = "~/coding/git/smart-floatterm.nvim"
end

return m
