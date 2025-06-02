local m = {
    "ingenarel/simple-runner.nvim",
    config = function()
        require("simple-runner").setup {
            heightPercentage = 70,
            widthPercentage = 80,
        }
        require("which-key").add {
            "<leader>r",
            function()
                require("simple-runner").run()
            end,
            desc = "Run file",
        }
    end,
}

if
    vim.uv.fs_stat(vim.fs.normalize("~/.config/shitbox/configs/programs/neovim/myPlugins/simple-runner.nvim")) ~= nil
then
    m.dir = "~/.config/shitbox/configs/programs/neovim/myPlugins/simple-runner.nvim"
end

return m
