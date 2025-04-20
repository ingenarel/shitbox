local m = {
    "ingenarel/cyberpunk-neon.nvim",
    config = function()
        vim.cmd.colorscheme("cyberpunk-neon")
    end,
}

if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/cyberpunk-neon.nvim")) ~= nil then
    m.dir = "~/coding/git/cyberpunk-neon.nvim"
end

return m
