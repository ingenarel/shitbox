require("which-key").add {
    {
        "<leader>f",
        function()
            require("telescope.builtin").find_files()
        end,
        desc = "find files",
    },
    {
        "<leader>o",
        function()
            require("telescope.builtin").oldfiles()
        end,
        desc = "Oldfiles",
    },
    {
        "<leader>tg",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
    },
    {
        "<leader>tb",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "Buffer list",
    },
    {
        "<leader>tt",
        function()
            require("telescope.builtin").treesitter()
        end,
        desc = "Treesitter Telescope",
    },
    {
        "<leader>T",
        function()
            require("telescope.builtin").builtin()
        end,
        desc = "Telescope",
    },
    {
        "<leader>u",
        function()
            require("telescope").extensions.undo.undo()
        end,
        desc = "Undo Tree",
    },
    {
        "<leader>ts",
        function()
            require("telescope.builtin").grep_string()
        end,
        desc = "Search for a string",
    },
    {
        "<leader>q",
        function()
            require("telescope.builtin").quickfix()
        end,
        desc = "Quickfix",
    },
    {
        "<leader>td",
        function()
            require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
    },
}
