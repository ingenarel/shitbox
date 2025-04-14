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
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        config = {
            ensure_installed = require("plugins.treesitter.ensure-installed"),
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true,
            },
        },
    },
}
