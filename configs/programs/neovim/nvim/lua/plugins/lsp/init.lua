return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        { "ms-jpq/coq_nvim", branch = "coq" },
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
        local lspconfig = require("lspconfig")
        require("plugins.lsp.python")
        require("plugins.lsp.lua")
        lspconfig.clangd.setup {}
        lspconfig.bashls.setup {
            settings = {
                bashIde = {
                    globPattern = "*@(.sh|.inc|.bash|.command)",
                },
            },
        }
        lspconfig.ltex_plus.setup {
            settings = {
                ltex = {
                    language = "en-GB",
                },
            },
        }
        lspconfig.yamlls.setup {}
        lspconfig.rust_analyzer.setup {
            settings = {
                ["rust-analyzer"] = {
                    diagnostics = {
                        enable = true,
                    },
                },
            },
        }
        require("plugins.lsp.termux-language-server")
        lspconfig.nil_ls.setup {}
    end,
}
