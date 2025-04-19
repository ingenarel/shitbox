require("which-key").add {
    {
        "<leader><leader>t",
        function()
            require("smart-floatterm").open()
        end,
        desc = "Terminal",
    },
}
