return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                c = { "clang-format" },
                bash = { "beautysh" },
                csh = { "beautysh" },
                ksh = { "beautysh" },
                zsh = { "beautysh" },
                sh = { "beautysh" },
                nix = { "alejandra" },
            },
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format { bufnr = args.buf }
            end,
        })
    end,
}
