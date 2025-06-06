local wk = require("which-key")

require("configs.keybinds.alt")

vim.keymap.set("n", "<leader>R", function()
    vim.cmd("w | source %")
end, { desc = "Saves and sources the file", silent = true, noremap = true })

require("configs.keybinds.dirChange")

-- File managing {{{1
CK_SetKeymap_n(
    "<leader>F",
    "<CMD>FloatermNew --width=0.95 --height=1.0 --title=YAZI --titleposition=center --opener=edit yazi<CR>",
    "Yazi"
)
-- File managing }}}1

---### executes a command with floaterm.
---@param autoclosevalue 0|1 see |floaterm_autoclose|
---this can also be used to use another shell such as bash, zsh, cmd, powershell, etc
function CK_FloatermExecuteCommand(autoclosevalue)
    if autoclosevalue == 1 or autoclosevalue == 0 then
    else
        vim.notify("autoclose value can either be 0 or 1", "ERROR")
        return nil
    end

    local command = vim.fn.input("Command")

    if command == "" then
        return nil
    end

    vim.cmd(
        "FloatermNew --width=1.0 --height=0.9 --title=Custom_Execution --titleposition=center --autoclose="
            .. autoclosevalue
            .. " "
            .. command
    )
end
vim.keymap.set("t", "<M-esc>", "<C-\\><C-n>", { silent = true, noremap = true })
-- terminal }}}1

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
