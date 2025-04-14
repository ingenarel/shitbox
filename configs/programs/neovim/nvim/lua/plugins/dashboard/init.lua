return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons", "ingenarel/randomtips-nvim" },
    config = function()
        require("dashboard").setup {
            theme = "doom",
            disable_move = true,
            config = {
                header = {},
                footer = require("randomtips").ReturnRandomTip(),
                packages = { enable = false },
                center = require("plugins.dashboard.dashboard-keys"),
            },
        }
        require("which-key").add { { "<leader>D", "<CMD>Dashboard<CR>", desc = "Dashboard" } }
    end,
}
