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
    {
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
    },
    {
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
    },

    {
        "<leader>cdz",
        function()
            vim.cmd("cd ~/.config/shitbox/configs/programs/zsh/config | pwd ")
        end,
        desc = "zsh config",
    },
}
