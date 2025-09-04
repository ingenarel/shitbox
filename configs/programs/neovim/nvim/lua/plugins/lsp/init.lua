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

        require("plugins.lsp.ltex_plus")

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

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if client:supports_method("textDocument/implementation") then
                    vim.keymap.set({ "n", "v" }, "<A-]>", function()
                        if vim.g.loaded_telescope == 1 then
                            require("telescope.builtin").lsp_implementations()
                        else
                            vim.lsp.buf.implementation()
                        end
                    end, { buffer = true })
                end
            end,
        })
    end,
}
