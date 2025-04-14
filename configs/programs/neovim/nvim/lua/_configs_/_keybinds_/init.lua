local wk = require("which-key")

require("_configs_._keybinds_.alt")

vim.keymap.set( -- saves and sources the file {{{
    "n",
    "<leader>R",
    function()
        vim.cmd([[
                w
                source%
            ]])
    end,
    { desc = "Saves and sources the file", silent = true, noremap = true }
) -- }}}

vim.keymap.set( -- Changes directory and shows the current dir {{{1
    "n",
    "<leader>cd",
    function()
        vim.cmd([[
                cd %:h
                pwd
            ]])
    end,
    { desc = "Changes directory and shows the current dir", silent = true, noremap = true }
) -- }}}1

vim.keymap.set( -- updater {{{1
    "n",
    "<F5>",
    function()
        vim.cmd([[
                MasonUpdate
                Mason
                Lazy clean
                Lazy update
            ]])
    end,
    { desc = "tries to update everything", silent = true, noremap = true }
) -- }}}1

vim.keymap.set( -- runner {{{1
    "n",
    "<leader>r",
    function()
        local current_filetype = vim.bo.filetype

        local function floating_terminal(title, stuff)
            vim.cmd(
                "FloatermNew --width=1.0 --height=0.95 --title="
                    .. title
                    .. " --titleposition=center --autoclose=0 "
                    .. stuff
            )
        end

        vim.cmd("w")

        local file_with_extension = vim.fn.expand("%:p")
        local file_without_extension = vim.fn.fnamemodify(file_with_extension, ":r")

        local function execute_with(title, program)
            floating_terminal(title, program .. ' "' .. file_with_extension .. '"')
        end

        if current_filetype == "python" then
            execute_with(current_filetype, current_filetype)
        elseif current_filetype == "sh" then
            floating_terminal(current_filetype, file_with_extension)
        elseif current_filetype == "c" then
            -- if using windows, make sure you set your CC variable
            -- i set it to `gcc -Wall -Wextra`
            -- local linuxbin = "./"
            -- if vim.fn.has("win32") == 1 then
            --     linuxbin = ""
            -- end
            floating_terminal(
                current_filetype,
                -- 'make "' .. file_without_extension .. '" && ' .. linuxbin .. '"' .. file_without_extension .. '"'
                'make "'
                    .. file_without_extension
                    .. '" && '
                    .. '"'
                    .. file_without_extension
                    .. '"'
            )
        elseif current_filetype == "lua" then
            execute_with(current_filetype, current_filetype)
        elseif current_filetype == "dosbatch" then
            floating_terminal("batch", "cmd /c % && exit")
        elseif current_filetype == "ps1" then
            execute_with("powershell", "powershell -File ")
        elseif current_filetype == "html" then -- change it to your browser, make sure the browser is on the path
            vim.cmd('!librewolf "' .. file_with_extension .. '"')
        else
            vim.notify("Filetype hasn't been implemented yet", "WARN")
        end
    end,
    { desc = "Try to run current file", silent = true, noremap = true }
) -- }}}1

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

require("_configs_._keybinds_._git_")
require("_configs_._keybinds_._window-nav_")
