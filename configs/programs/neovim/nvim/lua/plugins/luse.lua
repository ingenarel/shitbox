local m = {
    "ingenarel/luse.nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/luse.nvim")) ~= nil then
    m.dir = "~/coding/git/luse.nvim"
end

return m
