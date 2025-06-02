local m = {
    "ingenarel/focus-mode.nvim",
    config = function()
        require("which-key").add {
            {
                "<F2>",
                function()
                    require("focus-mode").toggle()
                end,
                desc = "Toggle Focus Mode",
            },
        }
    end,
}

if vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/focus-mode.nvim")) ~= nil then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/focus-mode.nvim"
end

return m
