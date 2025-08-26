local term = require("smart-term")
require("which-key").add {
    {
        "<leader><leader>t",
        function()
            require("smart-term").float { widthPercentage = 90 }
        end,
        desc = "Terminal",
    },
    {
        "<leader>gg",
        function()
            require("smart-term.neovim").float {
                widthPercentage = 90,
                heightPercentage = 90,
                command = "lazygit",
            }
        end,
        desc = "Lazygit",
    },
    { "<leader>F", group = "Yazi" },
    {
        "<leader>Ff",
        function()
            term.float {
                widthPercentage = 95,
                heightPercentage = 100,
                command = "yazi",
            }
        end,
        desc = "Project Dir",
    },
    {
        "<leader>Fd",
        function()
            term.float {
                widthPercentage = 95,
                heightPercentage = 100,
                command = "yazi " .. vim.fn.expand("%:h"),
            }
        end,
        desc = "Current File's Dir",
    },
}
