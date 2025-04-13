vim.opt.termguicolors = true -- enable more colors

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    -- TODO: download the profiler plugin somehow (https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md)
    -- TODO: download neovim tmux navigator (https://github.com/alexghergh/nvim-tmux-navigation) or create my own where the stupid c-l c-h isn't predefined
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
    spec = {
        {
            require("_plugins_._dashboard-setup_"),
            require("_plugins_._colorizer-setup_"),
            require("_plugins_._color-picker-setup_"),
            require("_plugins_._lualine-setup_"),
            require("_plugins_._autopairs-setup_"),
            require("_plugins_._telescope-setup_"),
            require("_plugins_._ibl-setup_"),
            { "lewis6991/gitsigns.nvim", config = true },
            require("_plugins_._metapack-setup_"),
            require("_plugins_._lspconfig-setup_"),
            require("_plugins_._dap-setup_"),
            require("_plugins_._treesitter-setup_"), -- config that has my lsp, dap and autocompletion config
            { "voldikss/vim-floaterm" }, -- floaterm, the floating terminal emulator in neovim
            require("_plugins_._focus-setup_"),
            { "https://gitlab.com/yorickpeterse/nvim-window.git" }, -- to quickly switch split buffers.
            -- TODO: fork this repo and make the code a bit better.{{{
            -- don't know lua that much, but lsp pointed out that it's using deprecated functions, and there's a function that's unused.
            -- it's a single file. not that big too. shouldn't be that hard to make it a bit better ig.}}}
            { "folke/which-key.nvim", event = "VeryLazy", config = { preset = "helix", no_overlap = true } }, -- for keybindings help
            { "ingenarel/nvim-pairMan" }, -- my plugin for pair stuff
            {
                "smoka7/hop.nvim",
                version = "*",
                config = { keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" },
            },
            { "m4xshen/hardtime.nvim", dependencies = { "MunifTanjim/nui.nvim" }, opts = { disabled_keys = "" } },
            { "folke/persistence.nvim", event = "BufReadPre", opts = {} },
            { "imsnif/kdl.vim", ft = "kdl" },
            { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
            require("_plugins_._conform-setup_"),
            {
                "christoomey/vim-tmux-navigator",
                cmd = {
                    "TmuxNavigateLeft",
                    "TmuxNavigateDown",
                    "TmuxNavigateUp",
                    "TmuxNavigateRight",
                    "TmuxNavigatePrevious",
                    "TmuxNavigatorProcessList",
                },
                keys = {
                    { "<M-H>", "<cmd>TmuxNavigateLeft<cr>" },
                    { "<M-J>", "<cmd>TmuxNavigateDown<cr>" },
                    { "<M-K>", "<cmd>TmuxNavigateUp<cr>" },
                    { "<M-L>", "<cmd>TmuxNavigateRight<cr>" },
                },
            },
            {
                "nvzone/typr",
                dependencies = "nvzone/volt",
                opts = {},
                cmd = { "Typr", "TyprStats" },
            },
            { "nvzone/showkeys", cmd = "ShowkeysToggle", opts = { timeout = 2, maxkeys = 9, position = "top-right" } },
            {
                "ingenarel/cyberpunk-neon.nvim",
                config = function()
                    vim.cmd.colorscheme("cyberpunk-neon")
                end,
            },
        },
    },
}
