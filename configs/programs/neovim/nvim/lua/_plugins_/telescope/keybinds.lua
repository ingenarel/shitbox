require("which-key").add {
    {
        "<leader>f",
        function()
            require("telescope.builtin").find_files()
        end,
        desc = "find files",
    },
    {
        "<leader>o",
        function()
            require("telescope.builtin").oldfiles()
        end,
        desc = "Oldfiles",
    },
    {
        "<leader>tg",
        function()
            require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
    },
    {
        "<leader>tb",
        function()
            require("telescope.builtin").buffers()
        end,
        desc = "Buffer list",
    },
    {
        "<leader>tt",
        function()
            require("telescope.builtin").treesitter()
        end,
        desc = "Treesitter Telescope",
    },
    {
        "<leader>T",
        function()
            require("telescope.builtin").builtin()
        end,
        desc = "Telescope",
    },
    {
        "<leader>u",
        function()
            require("telescope").extensions.undo.undo()
        end,
        desc = "Undo Tree",
    },
    {
        "<leader>ts",
        function()
            require("telescope.builtin").grep_string()
        end,
        desc = "Search for a string",
    },
    {
        "<leader>q",
        function()
            require("telescope.builtin").quickfix()
        end,
        desc = "Quickfix",
    },
    {
        "<leader>td",
        function()
            require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
    },
    {
        "<leader>gf",
        function()
            require("telescope.builtin").git_files()
        end,
        desc = "find files+gitfiles",
    },
    {
        "<leader>gb",
        function()
            require("telescope.builtin").git_branches()
        end,
        desc = "git branch list",
    },
    {
        "<leader>glc",
        function()
            require("telescope.builtin").git_commits()
        end,
        desc = "git commit list",
    },
    {
        "<leader>gs",
        function()
            require("telescope.builtin").git_status()
        end,
        desc = "git status",
    },
    { "<leader>wxf", "<C-w>v<C-w>w<CMD>Telescope find_files<CR>", desc = "⫸ files" },
    { "<leader>wxo", "<C-w>v<C-w>w<CMD>Telescope oldfiles<CR>", desc = "⫸ oldfiles" },
    { "<leader>wxG", "<C-w>v<C-w>w<CMD>Telescope git_files<CR>", desc = "⫸ gitfiles" },
    { "<leader>wxg", "<C-w>v<C-w>w<CMD>Telescope live_grep<CR>", desc = "⫸ grep" },
    { "<leader>wxs", "<C-w>v<C-w>w<CMD>Telescope grep_string<CR>", desc = "⫸ search current string" },
    { "<leader>wyf", "<C-w>s<C-w>w<CMD>Telescope find_files<CR>", desc = "ↆ files" },
    { "<leader>wyo", "<C-w>s<C-w>w<CMD>Telescope oldfiles<CR>", desc = "ↆ oldfiles" },
    { "<leader>wyG", "<C-w>s<C-w>w<CMD>Telescope git_files<CR>", desc = "ↆ gitfiles" },
    { "<leader>wyg", "<C-w>s<C-w>w<CMD>Telescope live_grep<CR>", desc = "ↆ grep" },
    { "<leader>wys", "<C-w>s<C-w>w<CMD>Telescope grep_string<CR>", desc = "ↆ search current string" },
}
