require("which-key").add {
    {
        "<leader><leader>t",
        function()
            require("smart-term").openFloaTerm { widthPercentage = 90 }
        end,
        desc = "Terminal",
    },
    {
        "<leader>gg",
        function()
            require("smart-term").openNeovimFloaTerm { widthPercentage = 90, heightPercentage = 90, command = "lazygit" }
        end,
        desc = "Lazygit",
    },
}
