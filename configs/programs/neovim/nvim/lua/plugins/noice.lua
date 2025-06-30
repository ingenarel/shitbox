return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        presets = {
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = true,
        },
    },
    dependencies = { "MunifTanjim/nui.nvim", { "rcarriga/nvim-notify", opts = {} } },
}
