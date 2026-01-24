return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
        -- configuration
        require("nvim-treesitter-textobjects").setup {
            select = {
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@function.inner"] = "V", -- linewise
                    ["@class.outer"] = "V", -- linewise
                    ["@class.inner"] = "V", -- linewise
                    ["@loop.outer"] = "V", -- linewise
                    ["@loop.inner"] = "V", -- linewise
                },
                include_surrounding_whitespace = false,
            },
        }
        require("plugins.treesitter.keymaps")
    end,
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            lazy = false,
            branch = "main",
            config = function()
                require("nvim-treesitter").setup {
                    install_dir = vim.fn.stdpath("data") .. "/site",
                }
                local langs = {}
                for lang, _ in pairs(require("nvim-treesitter.parsers")) do
                    table.insert(langs, lang)
                end
                require("nvim-treesitter").install(langs, { max_jobs = 4 })
                vim.treesitter.language.register("bash", "ebuild")
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false, -- Enable multiwindow support.
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            },
        },
    },
}
