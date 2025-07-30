return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "ms-jpq/coq_nvim", branch = "coq" },
        { "barreiroleo/ltex_extra.nvim", branch = "dev" },
    },
    init = function()
        vim.g.coq_settings = {
            auto_start = "shut-up",
            keymap = {
                eval_snips = "<leader>cs",
                recommended = false,
                jump_to_mark = "<M-h>",
            },
            display = {
                preview = {
                    resolve_timeout = 1,
                },
                mark_applied_notify = false,
            },
        }
    end,
    config = function()
        require("plugins.lsp.python")
        require("plugins.lsp.lua")
        vim.lsp.enable("clangd")

        vim.lsp.enable("bashls")
        vim.lsp.config("bashls", {
            settings = {
                bashIde = {
                    globPattern = "*@(.sh|.inc|.bash|.command)",
                },
            },
        })

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

        vim.lsp.enable("yamlls")

        vim.lsp.enable("rust_analyzer")
        vim.lsp.config("rust_analyzer", {
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = true,
                    },
                },
            },
        })

        require("plugins.lsp.termux-language-server")
        vim.lsp.enable("nil_ls")
        vim.lsp.enable("jsonls")
    end,
}
