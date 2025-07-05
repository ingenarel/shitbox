require("which-key").add {
    { "<leader>cd", group = "Dir change" },
    {
        "<leader>cdd",
        function()
            local dir = vim.fn.expand("%:h")
            local gitRoot = vim.system({ "git", "-C", dir, "rev-parse", "--show-toplevel" }):wait().stdout
            if gitRoot ~= "" then
                dir = gitRoot
            end
            vim.cmd("cd " .. dir .. " | pwd ")
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
