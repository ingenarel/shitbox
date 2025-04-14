return {
    {
        desc = "Find Files",
        action = function()
            require("telescope.builtin").find_files {
                layout_config = {
                    height = { padding = 0 },
                    width = { padding = 0 },
                },
            }
        end,
        key = "f",
        key_format = " %s",
    },
    {
        desc = "Yazi",
        action = "FloatermNew --width=1.0 --height=1.0 --title=YAZI --titleposition=center --opener=edit yazi",
        key = "y",
        key_format = " %s",
    },
    {
        desc = "Find Git Files",
        action = function()
            require("telescope.builtin").git_files {
                layout_config = {
                    height = { padding = 0 },
                    width = { padding = 0 },
                },
            }
        end,
        key = "F",
        key_format = " %s",
    },
    {
        desc = "Grep",
        action = function()
            require("telescope.builtin").live_grep {
                layout_config = {
                    height = { padding = 0 },
                    width = { padding = 0 },
                },
            }
        end,
        key = "g",
        key_format = " %s",
    },
    {
        desc = "Old Files",
        action = function()
            require("telescope.builtin").oldfiles {
                layout_config = {
                    height = { padding = 0 },
                    width = { padding = 0 },
                },
            }
        end,
        key = "o",
        key_format = " %s",
    },
    {
        desc = "Telescope",
        action = function()
            require("telescope.builtin").builtin {
                layout_config = {
                    height = { padding = 0 },
                    width = { padding = 0 },
                },
            }
        end,
        key = "t",
        key_format = " %s",
    },
    {
        desc = "Lazygit",
        action = "FloatermNew --width=1.0 --height=1.0 --title=LAZYGIT --titleposition=center lazygit",
        key = "G",
        key_format = " %s",
    },
    {
        desc = "Help",
        action = function()
            local help = vim.fn.input("help => ", "", "help")
            if help == "" then
                return 0
            end
            vim.cmd("h " .. help)
            CK_SimKeys("<C-w>w<C-w>c")
        end,
        key = "h",
        key_format = " %s",
    },
    {
        desc = "Help Grep",
        action = function()
            local help = vim.fn.input("Help Grep => ", "", "help")
            if help == "" then
                return 0
            end
            vim.cmd("helpg " .. help .. "\\c")
            CK_SimKeys("<CR><C-w>w<C-w>c<CMD>Telescope quickfix<CR>")
        end,
        key = "H",
        key_format = " %s",
    },
    {
        desc = "Last session",
        action = function()
            require("persistence").load { last = true }
        end,
        key = "l",
        key_format = " %s",
    },
    {
        desc = "Last session (cwd)",
        action = function()
            require("persistence").load()
        end,
        key = "L",
        key_format = " %s",
    },
    {
        desc = "Last session (pick)",
        action = function()
            require("persistence").select()
        end,
        key = "<M-l>",
        key_format = " %s",
    },
}
