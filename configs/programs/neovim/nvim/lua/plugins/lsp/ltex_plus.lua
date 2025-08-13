-- TODO: FIX THE STUPID SETTINGS FILE NOT LOADING
local function find_root()
    local file_path = vim.api.nvim_buf_get_name(0)
    local root_pattern = require("lspconfig").util.root_pattern
    return root_pattern(".ltex", ".hg", ".git")(file_path) or vim.fn.fnamemodify(file_path, ":p:h")
end
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
                },
            },
        },
        checkFrequency = "save",
    },
    on_attach = function(client, bufnr)
        require("ltex_extra").setup {
            load_langs = { "en-GB" },
            path = find_root(),
        }
    end,
})
