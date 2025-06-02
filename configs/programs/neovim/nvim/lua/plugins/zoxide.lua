local m = {
    "ingenarel/zoxide.nvim",
    opts = true,
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/zoxide.nvim")) ~= nil then
    m.dir = "~/coding/git/zoxide.nvim"
end

return m
