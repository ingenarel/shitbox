return {
    { "<leader>cdn", group = "neovim" },
    {
        "<leader>cdnn",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/nvim | pwd ")
        end,
        desc = "neovim config",
    },

    {
        "<leader>cdnc",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/cyberpunk-neon.nvim | pwd ")
        end,
        desc = "cyberpunk-neon.nvim",
    },

    {
        "<leader>cdnf",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/focus-mode.nvim | pwd ")
        end,
        desc = "focus-mode.nvim",
    },

    {
        "<leader>cdnl",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/luix.nvim | pwd ")
        end,
        desc = "luix.nvim",
    },

    {
        "<leader>cdnL",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/luse.nvim | pwd ")
        end,
        desc = "luse.nvim",
    },

    {
        "<leader>cdnm",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/metapack.nvim | pwd ")
        end,
        desc = "metapack.nvim",
    },

    {
        "<leader>cdnp",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/nvim-pairMan | pwd ")
        end,
        desc = "nvim-pairMan",
    },

    {
        "<leader>cdnR",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/randomtips-nvim | pwd ")
        end,
        desc = "randomtips-nvim",
    },

    {
        "<leader>cdnz",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/zoxide.nvim | pwd ")
        end,
        desc = "zoxide.nvim",
    },

    {
        "<leader>cdnt",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/smart-term.nvim | pwd ")
        end,
        desc = "smart-term.nvim",
    },

    {
        "<leader>cdnr",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/simple-runner.nvim | pwd ")
        end,
        desc = "simple-runner.nvim",
    },

    {
        "<leader>cdns",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/flex-stats.nvim | pwd ")
        end,
        desc = "flex-stats.nvim",
    },
}
