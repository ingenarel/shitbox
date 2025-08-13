vim.lsp.enable("ltex_plus")
vim.lsp.config("ltex_plus", {
    settings = {
        ltex = {
            language = "en-GB",
            dictionary = {
                ["en-GB"] = {
                    "bytecode",
                    "helptag",
                    "lazypath",
                    "libuv",
                    "nvim",
                    "runtimepath",
                    "vimdocs",
                    "Treesitter",
                    "nvim-treesitter",
                    "metapack",
                },
            },
            disabledRules = {
                ["en-GB"] = {
                    "GONNA",
                    "LC_AFTER_PERIOD",
                    "WHOLE_LOT",
                    "MORFOLOGIK_RULE_EN_GB",
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        require("ltex_extra").setup { load_langs = { "en-GB" } }
    end,
})
