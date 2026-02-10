return {
    { "<leader>cdw", group = "window managers" },
    {
        "<leader>cdwh",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/WM/hyprland/config | pwd ")
        end,
        desc = "hyprland config",
    },

    {
        "<leader>cdws",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/WM/sway | pwd ")
        end,
        desc = "sway config",
    },

    {
        "<leader>cdwr",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/WM/river | pwd ")
        end,
        desc = "river config",
    },
    {
        "<leader>cdwm",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/WM/mango | pwd ")
        end,
        desc = "mangowc config",
    },
}
