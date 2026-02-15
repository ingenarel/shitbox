return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        -- require("plugins.coq_nvim"),
        require("plugins.blink-cmp"),
        { "barreiroleo/ltex_extra.nvim", branch = "dev" },
    },
    config = function()
        vim.lsp.log.set_level("ERROR")
        vim.lsp.linked_editing_range.enable(true)
        require("plugins.lsp.python")
        require("plugins.lsp.lua")
        vim.lsp.enable("clangd")

        require("plugins.lsp.bashls")

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
        vim.lsp.enable("docker_language_server")
        vim.lsp.enable("ast_grep")
        vim.lsp.config("ast_grep", {
            -- these are the default options, you only need to specify
            -- options you'd like to change from the default
            cmd = { "ast-grep", "lsp" },
            filetypes = {
                "c",
                "cpp",
                "rust",
                "go",
                "java",
                "python",
                "javascript",
                "typescript",
                "html",
                "css",
                "kotlin",
                "dart",
                "lua",
            },
        })
        vim.lsp.enable("tombi")
    end,
}
