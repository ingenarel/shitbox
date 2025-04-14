local wk = require("which-key")

require("_configs_.keybinds.alt")

vim.keymap.set("n", "<leader>R", function()
    vim.cmd("w | source %")
end, { desc = "Saves and sources the file", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cd", function()
    vim.cmd("cd %:h | pwd ")
end, { desc = "Changes directory and shows the current dir", silent = true, noremap = true })

vim.keymap.set("n", "<F5>", function()
    vim.cmd(" MasonUpdate | Mason | Lazy clean | Lazy update ")
end, { desc = "tries to update everything", silent = true, noremap = true })

require("_configs_.keybinds.runner")

-- focus mode (hides most stuff) {{{1
CV_IsFocusModeOn = false
vim.keymap.set("n", "<F2>", function()
    local vol = vim.opt_local

    if CV_IsFocusModeOn == false then
        CV_IsFocusModeOn = true
        vol.foldcolumn = "0"
        vol.colorcolumn = ""
        vol.number = false
        vol.relativenumber = false
        vol.signcolumn = "no"
        vol.cursorcolumn = false
        vol.cursorline = false
        vol.laststatus = 0
        require("ibl").update { enabled = false }
        -- TODO: fix this; this is probably fucking crashing clangd
        -- vim.diagnostic.config{virtual_text=false}
        vim.fn.system { "tmux", "set", "-g", "status", "off" }
    elseif CV_IsFocusModeOn == true then
        CV_IsFocusModeOn = false
        vol.foldcolumn = "auto"
        vol.colorcolumn = "+0,-20,-40"
        vol.number = true
        vol.relativenumber = true
        vol.signcolumn = "auto"
        vol.cursorcolumn = true
        vol.cursorline = true
        vol.laststatus = 3
        require("ibl").update { enabled = true }
        -- vim.diagnostic.config{virtual_text=true}
        vim.fn.system { "tmux", "set", "-g", "status", "on" }
    end
end, { silent = true, noremap = true, desc = "Toggle Focus Mode" }) -- }}}1

-- File managing {{{1
CK_SetKeymap_n(
    "<leader>F",
    "<CMD>FloatermNew --width=0.95 --height=1.0 --title=YAZI --titleposition=center --opener=edit yazi<CR>",
    "Yazi"
)
-- File managing }}}1

-- terminal {{{1
CK_SetKeymap_n(
    "<leader><leader>t",
    "<CMD>FloatermNew --width=1.0 --height=0.9 --title=TERMINAL --titleposition=center<CR>",
    "Terminal"
)

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
vim.keymap.set("n", "<leader><leader>e", function()
    CK_FloatermExecuteCommand(1)
end, { desc = "Execute command and tries to close the terminal", silent = true, noremap = true })
vim.keymap.set("n", "<leader><leader>E", function()
    CK_FloatermExecuteCommand(0)
end, { desc = "Execute command and keeps the terminal open", silent = true, noremap = true })
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

require("_configs_.keybinds._git_")
require("_configs_.keybinds._window-nav_")
