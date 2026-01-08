vim.opt.termguicolors = true -- enable more colors

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local out = vim.system({
        "git",
        "clone",
        "--depth=10",
        "--branch=main",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }):wait()

    if out.code ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out.stderr, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    -- TODO: download the profiler plugin somehow (https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md)
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
    version = nil,
    spec = {
        {
            { "folke/which-key.nvim", event = "VeryLazy", config = { preset = "helix", no_overlap = true } }, -- for keybindings help
            require("plugins.dashboard"),
            require("plugins.colorizer"),
            require("plugins.color-picker"),
            require("plugins.lualine"),
            require("plugins.autopairs"),
            require("plugins.telescope"),
            require("plugins.ibl"),
            require("plugins.gitsigns"),
            require("plugins.metapack"),
            require("plugins.lsp"),
            require("plugins.dap"),
            require("plugins.treesitter"), -- config that has my lsp, dap and autocompletion config
            require("plugins.smart-term"),
            require("plugins.focus"),
            { "https://gitlab.com/yorickpeterse/nvim-window.git" }, -- to quickly switch split buffers.
            -- TODO: fork this repo and make the code a bit better.{{{
            -- don't know lua that much, but lsp pointed out that it's using deprecated functions, and there's a function that's unused.
            -- it's a single file. not that big too. shouldn't be that hard to make it a bit better ig.}}}
            require("plugins.pairMan"), -- my plugin for pair stuff

            {
                "smoka7/hop.nvim",
                version = "*",
                config = { keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" },
            },
            {
                "m4xshen/hardtime.nvim",
                dependencies = { "MunifTanjim/nui.nvim" },
                opts = { disabled_filetypes = { metapack = true, flexstats = true } },
            },
            { "folke/persistence.nvim", event = "BufReadPre", opts = {} },
            { "imsnif/kdl.vim", ft = "kdl" },
            { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
            require("plugins.conform"),
            {
                "dynamotn/Navigator.nvim",
                config = true,
                cmd = {
                    "NavigatorLeft",
                    "NavigatorDown",
                    "NavigatorUp",
                    "NavigatorRight",
                    "NavigatePrevious",
                },
                keys = {
                    { "<M-H>", "<cmd>NavigatorLeft<cr>" },
                    { "<M-J>", "<cmd>NavigatorDown<cr>" },
                    { "<M-K>", "<cmd>NavigatorUp<cr>" },
                    { "<M-L>", "<cmd>NavigatorRight<cr>" },
                },
            },
            {
                "nvzone/typr",
                dependencies = "nvzone/volt",
                opts = {},
                cmd = { "Typr", "TyprStats" },
            },
            { "nvzone/showkeys", cmd = "ShowkeysToggle", opts = { timeout = 2, maxkeys = 9, position = "top-right" } },
            require("plugins.cyberpunk-neon"), -- ingenarel/cyberpunk-neon.nvim
            require("plugins.simple-runner"),
            require("plugins.focus-mode"),
            {
                "vyfor/cord.nvim",
                build = ":Cord update",
                opts = {},
            },
            require("plugins.zoxide"),
            --TODO: find a fix for noice skipping messages that were already shown
            -- require("plugins.noice"),
            require("plugins.flex-stats"),
            {
                "j-hui/fidget.nvim",
                opts = {
                    -- options
                },
            },
        },
    },
}
