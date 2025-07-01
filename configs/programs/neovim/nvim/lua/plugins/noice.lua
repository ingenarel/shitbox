return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = true,
        },
        views = {
            cmdline_popup = {
                position = {
                    row = math.floor(vim.o.lines / 2 - 10),
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "#000000",
            },
        },
    },
}
