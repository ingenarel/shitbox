local wk = require("which-key")

wk.add {
    { "<leader>i", group = "inner swap" },
    { "<leader>a", group = "around swap" },
}

for key, value in pairs {
    a = "@assignment",
    A = "@attribute",
    b = "@block",
    ca = "@call",
    cl = "@class",
    co = "@comment",
    cn = "@conditional",
    f = "@function",
    F = "@frame",
    l = "@loop",
    p = "@parameter",
    r = "@regex",
    R = "@return",
} do
    vim.keymap.set({ "x", "o" }, "i" .. key, function()
        require("nvim-treesitter-textobjects.select").select_textobject(value .. ".inner", "textobjects")
    end, { desc = value })
    vim.keymap.set({ "x", "o" }, "a" .. key, function()
        require("nvim-treesitter-textobjects.select").select_textobject(value .. ".outer", "textobjects")
    end, { desc = value })

    vim.keymap.set({ "n", "x", "o" }, "]i" .. key, function()
        require("nvim-treesitter-textobjects.move").goto_next(value .. ".inner", "textobjects")
    end, { desc = value })
    vim.keymap.set({ "n", "x", "o" }, "]a" .. key, function()
        require("nvim-treesitter-textobjects.move").goto_next(value .. ".outer", "textobjects")
    end, { desc = value })

    vim.keymap.set({ "n", "x", "o" }, "[i" .. key, function()
        require("nvim-treesitter-textobjects.move").goto_previous(value .. ".inner", "textobjects")
    end, { desc = value })
    vim.keymap.set({ "n", "x", "o" }, "[a" .. key, function()
        require("nvim-treesitter-textobjects.move").goto_previous(value .. ".outer", "textobjects")
    end, { desc = value })
    wk.add {
        { "<leader>i" .. key, group = value },
        { "<leader>a" .. key, group = value },
        {
            "<leader>i" .. key .. "n",
            function()
                require("nvim-treesitter-textobjects.swap").swap_next(value .. ".inner")
                vim.defer_fn(function()
                    wk.show { keys = "<leader>i" .. key }
                end, 15)
            end,
            desc = value,
        },
        {
            "<leader>i" .. key .. "p",
            function()
                require("nvim-treesitter-textobjects.swap").swap_previous(value .. ".inner")
                vim.defer_fn(function()
                    wk.show { keys = "<leader>i" .. key }
                end, 15)
            end,
            desc = value,
        },
        {
            "<leader>a" .. key .. "n",
            function()
                require("nvim-treesitter-textobjects.swap").swap_next(value .. ".outer")
                vim.defer_fn(function()
                    wk.show { keys = "<leader>a" .. key }
                end, 15)
            end,
            desc = value,
        },
        {
            "<leader>a" .. key .. "p",
            function()
                require("nvim-treesitter-textobjects.swap").swap_previous(value .. ".outer")
                vim.defer_fn(function()
                    wk.show { keys = "<leader>a" .. key }
                end, 15)
            end,
            desc = value,
        },
    }
end
