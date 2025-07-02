return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    main = "nvim-treesitter.configs",
    config = {
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "Function" },
                    ["if"] = { query = "@function.inner", desc = "Function" },
                    ["ac"] = { query = "@class.outer", desc = "Class" },
                    ["ic"] = { query = "@class.inner", desc = "Class" },
                    ["al"] = { query = "@loop.outer", desc = "Loop" },
                    ["il"] = { query = "@loop.inner", desc = "Loop" },
                    ["aa"] = { query = "@assignment.outer", desc = "Assignment" },
                    ["ia"] = { query = "@assignment.inner", desc = "Assignment" },
                    ["H"] = { query = "@assignment.lhs", desc = "Assignment LHS" },
                    ["L"] = { query = "@assignment.rhs", desc = "Assignment RHS" },
                    ["ar"] = { query = "@regex.outer", desc = "Regex" },
                    ["ir"] = { query = "@regex.inner", desc = "Regex" },
                    ["aR"] = { query = "@return.outer", desc = "Return" },
                    ["iR"] = { query = "@return.inner", desc = "Return" },
                },
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    ["@class.outer"] = "<c-q>", -- blockwise
                },
                include_surrounding_whitespace = true,
            },
        },
    },
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = require("plugins.treesitter.ensure-installed"),
                    sync_install = false,
                    auto_install = false,
                    highlight = {
                        enable = true,
                    },
                }
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
