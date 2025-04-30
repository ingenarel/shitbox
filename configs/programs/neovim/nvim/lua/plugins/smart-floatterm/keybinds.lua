require("which-key").add {
    {
        "<leader><leader>t",
        function()
            require("smart-floatterm").open { widthPercentage = 90 }
        end,
        desc = "Terminal",
    },
    {
        "<leader>gg",
        function()
            require("smart-floatterm").open { widthPercentage = 90, heightPercentage = 90, command = "lazygit" }
        end,
        desc = "Lazygit",
    },
}
