local m = {
    "ingenarel/randomtips-nvim",
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/randomtips-nvim")) ~= nil then
    m.dir = "~/coding/git/randomtips-nvim"
end

return m
