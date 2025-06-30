local wk = require("which-key")

require("configs.keybinds.alt")

vim.keymap.set("n", "<leader>R", function()
    vim.cmd("w | source %")
end, { desc = "Saves and sources the file", silent = true, noremap = true })

require("configs.keybinds.dirChange")

-- File managing {{{
CK_SetKeymap_n(
    "<leader>F",
    "<CMD>FloatermNew --width=0.95 --height=1.0 --title=YAZI --titleposition=center --opener=edit yazi<CR>",
    "Yazi"
)
-- File managing }}}

vim.keymap.set("t", "<M-esc>", "<C-\\><C-n>", { silent = true, noremap = true })

vim.keymap.set("n", "grn", function()
    vim.lsp.buf.rename()
end, { silent = true, noremap = true })
require("pairMan").setup { keymap = "<leader>p" }
wk.add {
    { "<leader>pha", proxy = "<leader>pah" },
    { "<leader>phi", proxy = "<leader>pih" },
}

CK_SetKeymap_n("<leader>l", "<CMD>set wrap!<CR>", "Toggles line wrap")
CK_SetKeymap_n("<leader><m-t>", "<CMD>InspectTree<CR>", "Inspect Treesitter tree")
vim.keymap.set("n", "<Up>", ":<Up>", { desc = "Previous command", silent = true, noremap = true })

require("configs.keybinds._git_")
require("configs.keybinds._window-nav_")
