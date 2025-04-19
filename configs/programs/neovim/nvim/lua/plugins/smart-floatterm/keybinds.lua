require("which-key").add {
    {
        "<leader><leader>t",
        function()
            require("smart-floatterm").open { widthPercentage = 90 }
        end,
        desc = "Terminal",
    },
}
