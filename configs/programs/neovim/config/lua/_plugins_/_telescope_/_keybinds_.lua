vim.keymap.set("n", "<leader>o", function()
    require("telescope.builtin").oldfiles()
end, { desc = "Oldfiles" })

vim.keymap.set("n", "<leader>tg", function()
    require("telescope.builtin").live_grep()
end, { desc = "Live Grep" })

vim.keymap.set("n", "<leader>tb", function()
    require("telescope.builtin").buffers()
end, { desc = "Buffer list" })

vim.keymap.set("n", "<leader>tt", function()
    require("telescope.builtin").treesitter()
end, { desc = "Treesitter Telescope" })

vim.keymap.set("n", "<leader>T", function()
    require("telescope.builtin").builtin()
end, { desc = "Telescope" })

vim.keymap.set("n", "<leader>u", function()
    require("telescope").extensions.undo.undo()
end, { desc = "Undo Tree" })

vim.keymap.set("n", "<leader>ts", function()
    require("telescope.builtin").grep_string()
end, { desc = "Search for a string" })

vim.keymap.set("n", "<leader>q", function()
    require("telescope.builtin").quickfix()
end, { desc = "Quickfix" })

vim.keymap.set("n", "<leader>td", function()
    require("telescope.builtin").diagnostics()
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>f", function()
    require("telescope.builtin").find_files()
end, { desc = "find files" })

vim.keymap.set("n", "<leader>gf", function()
    require("telescope.builtin").git_files()
end, { desc = "find files+gitfiles" })

vim.keymap.set("n", "<leader>gb", function()
    require("telescope.builtin").git_branches()
end, { desc = "git branch list" })

vim.keymap.set("n", "<leader>glc", function()
    require("telescope.builtin").git_commits()
end, { desc = "git commit list" })

vim.keymap.set("n", "<leader>gs", function()
    require("telescope.builtin").git_status()
end, { desc = "git status" })

CK_SetKeymap_n("<leader>wxf", "<C-w>v<C-w>w:Telescope find_files<CR>", "⫸ files")
CK_SetKeymap_n("<leader>wxo", "<C-w>v<C-w>w:Telescope oldfiles<CR>", "⫸ oldfiles")
CK_SetKeymap_n("<leader>wxG", "<C-w>v<C-w>w:Telescope git_files<CR>", "⫸ gitfiles")
CK_SetKeymap_n("<leader>wxg", "<C-w>v<C-w>w:Telescope live_grep<CR>", "⫸ grep")
CK_SetKeymap_n("<leader>wxs", "<C-w>v<C-w>w:Telescope grep_string<CR>", "⫸ search current string")
CK_SetKeymap_n("<leader>wyf", "<C-w>s<C-w>w:Telescope find_files<CR>", "ↆ files")
CK_SetKeymap_n("<leader>wyo", "<C-w>s<C-w>w:Telescope oldfiles<CR>", "ↆ oldfiles")
CK_SetKeymap_n("<leader>wyG", "<C-w>s<C-w>w:Telescope git_files<CR>", "ↆ gitfiles")
CK_SetKeymap_n("<leader>wyg", "<C-w>s<C-w>w:Telescope live_grep<CR>", "ↆ grep")
CK_SetKeymap_n("<leader>wys", "<C-w>s<C-w>w:Telescope grep_string<CR>", "ↆ search current string")
