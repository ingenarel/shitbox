local m = {
    "ingenarel/luix.nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/luix.nvim")) ~= nil then
    m.dir = "~/coding/git/luix.nvim"
end

return m
