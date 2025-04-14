require("which-key").add {
    {
        "<leader>dd",
        function()
            require("dapui").toggle()
        end,
        desc = "Dap ui toggle",
    },
    { "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Breakpoint toggle" },
    { "<leader>d<CR><CR>", "<CMD>DapContinue<CR>", desc = "DapContinue" },
    {
        "<leader>dl",
        function()
            require("dap").step_over()
            vim.defer_fen(function()
                require("which-key").show { keys = "<leader>d" }
            end, 150)
        end,
        desc = "DapStepOver",
    },
    {
        "<leader>dj",
        function()
            require("dap").step_into()
            vim.defer_fn(function()
                require("which-key").show { keys = "<leader>d" }
            end, 150)
        end,
        desc = "DapStepInto",
    },
    {
        "<leader>dh",
        function()
            require("dap").step_out()
            vim.defer_fen(function()
                require("which-key").show { keys = "<leader>d" }
            end, 150)
        end,
        desc = "DapStepOut",
    },
}
