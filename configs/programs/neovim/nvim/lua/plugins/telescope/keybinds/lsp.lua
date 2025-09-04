require("which-key").add {
    { "<leader>l", group = "LSP" },
    {
        "<leader>lr",
        function()
            require("telescope.builtin").lsp_references()
        end,
        desc = "References",
    },
    {
        "<leader>ls",
        function()
            require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Document symbols",
    },
    {
        "<leader>lS",
        function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "Dynamic workspace symbols",
    },
    {
        "<leader><M-s>",
        function()
            require("telescope.builtin").lsp_workspace_symbols()
        end,
        desc = "Workspace symbols",
    },
    {
        "<leader>lo",
        function()
            require("telescope.builtin").lsp_outgoing_calls()
        end,
        desc = "Outgoing calls",
    },
    {
        "<leader>li",
        function()
            require("telescope.builtin").lsp_incoming_calls()
        end,
        desc = "Incoming calls",
    },
}
