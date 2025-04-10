return {
    "stevearc/conform.nvim",
    opts = {
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
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
    },
}
