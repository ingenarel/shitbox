require("which-key").add {
    { "<leader>cd", group = "Dir change" },
    {
        "<leader>cdd",
        function()
            vim.cmd("cd %:h | pwd ")
        end,
        desc = "Current file's dir",
    },
    {
        "<leader>cds",
        function()
            vim.cmd("cd ~/.config/shitbox | pwd ")
        end,
        desc = "shitbox",
    },
    require("configs.keybinds.dirChange.neovim"),
    require("configs.keybinds.dirChange.WM"),
    {
        "<leader>cdz",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/zsh/config | pwd ")
        end,
        desc = "zsh config",
    },
}
