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
        lspconfig.pyright.setup {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "default",
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        logLevel = "error",
                    },
                },
            },
        }

        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- library = table.insert(vim.api.nvim_get_runtime_file("", true), "${3rd}/luv/library")
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library",
                            vim.fn.stdpath("data") .. "/lazy",
                            -- "${3rd}/busted/library",
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }

        -- TODO: make a good clangd setup from the config
        -- current i'm putting a config.yaml file in my clangd config dir.
        -- ```yaml
        -- CompileFlags:
        --   Add: [-Wall, -Wextra]
        -- ```

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
        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            pattern = {
                "build.sh",
                "*.subpackage.sh",
                "PKGBUILD",
                "*.install",
                "makepkg.conf",
                "*.ebuild",
                "*.eclass",
                "color.map",
                "make.conf",
            },
            callback = function()
                vim.lsp.start {
                    name = "termux",
                    cmd = { "termux-language-server" },
                }
            end,
        })

        lspconfig.nil_ls.setup {}
    end,
}
