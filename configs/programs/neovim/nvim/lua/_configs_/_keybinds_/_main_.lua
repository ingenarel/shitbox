local wk = require("which-key")

-- alt mappings {{{
-- map right alt to <ESC>. on windows, i use powertoys.
-- NOTE: need to use these mappings more often.
local function alt_keymap(keymap, action)
    vim.keymap.set({ "n", "v", "o", "i", "c", "t" }, keymap, action)
end

-- <M-h> is mapped to coq_settings.keymap.jump_to_mark
alt_keymap("<M-]>", "<C-]>")
alt_keymap("<M-d>", "<C-d>")
alt_keymap("<M-i>", "<C-i>")
alt_keymap("<M-l>", "<C-l><CMD>ColorizerReloadAllBuffers<CR>")
alt_keymap("<M-n>", "<C-n>")
alt_keymap("<M-o>", "<C-o>")
alt_keymap("<M-p>", "<C-p>")
alt_keymap("<M-q>", "<C-q>")
alt_keymap("<M-r>", "<C-r>")
alt_keymap("<M-u>", "<C-u>")
vim.keymap.set("i", "<M-w>", "<C-w>")
vim.keymap.set({ "n", "v", "o" }, "<M-/>", function()
    vim.cmd("HopAnywhereAC")
end)
vim.keymap.set({ "n", "v", "o" }, "<M-?>", function()
    vim.cmd("HopAnywhereBC")
end)
vim.keymap.set({ "n", "v", "o" }, "<M-f>", function()
    vim.cmd("HopChar1AC")
end)
vim.keymap.set({ "n", "v", "o" }, "<M-F>", function()
    vim.cmd("HopChar1BC")
end)
vim.keymap.set({ "n", "v", "o" }, "<M-j>", function()
    vim.cmd("HopLineAC")
end)
vim.keymap.set({ "n", "v", "o" }, "<M-k>", function()
    vim.cmd("HopLineBC")
end)
-- alt mappings }}}

vim.keymap.set( -- saves and sources the file {{{
    "n",
    "<leader>R",
    function()
        vim.cmd([[
                w
                source%
            ]])
    end,
    { desc = "Saves and sources the file" }
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
    { desc = "Changes directory and shows the current dir" }
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
    { desc = "tries to update everything" }
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
    { desc = "Try to run current file" }
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
end) -- }}}1

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
end, { desc = "Execute command and tries to close the terminal" })
vim.keymap.set("n", "<leader><leader>E", function()
    CK_FloatermExecuteCommand(0)
end, { desc = "Execute command and keeps the terminal open" })
vim.keymap.set("t", "<M-esc>", "<C-\\><C-n>")
-- terminal }}}1

-- color-picker {{{1
local color_picker = require("color-picker")
local function CK_set_color_picker_keymaps(base_key, mode) -- this function and the remapping was generated by chatgpt
    local sizes = { 20, 30, 40, 50, 60, 70, 80, 90, 100 }
    vim.keymap.set("n", base_key .. "r", color_picker[mode])
    for i, size in ipairs(sizes) do
        vim.keymap.set("n", base_key .. (i + 1), function()
            color_picker[mode] { height = size, width = size * 2 }
        end)
    end
end
CK_set_color_picker_keymaps("<leader>cpr", "replace")
CK_set_color_picker_keymaps("<leader>cpi", "insert")
CK_SetKeymap_n("<leader>cpRh", "<CMD>ColorPickerReformat hex<CR>") -- color picker reformat hex
CK_SetKeymap_n("<leader>cpRr", "<CMD>ColorPickerReformat rgb<CR>") -- color picker reformat rgb
CK_SetKeymap_n("<leader>cpRa", "<CMD>ColorPickerReformat rgba<CR>") -- color picker reformat rgba
-- color-picker }}}1

-- dap {{{1
vim.keymap.set("n", "<leader>dd", function()
    require("dapui").toggle()
end, { desc = "Dap ui toggle" })
CK_SetKeymap_n("<leader>db", "<CMD>DapToggleBreakpoint<CR>", "Breakpoint toggle")
CK_SetKeymap_n("<leader>d<CR><CR>", "<CMD>DapContinue<CR>", "DapContinue")
vim.keymap.set("n", "<leader>dl", function()
    require("dap").step_over()
    vim.defer_fen(function()
        require("which-key").show { keys = "<leader>d" }
    end, 150)
end, { desc = "DapStepOver" })
vim.keymap.set("n", "<leader>dj", function()
    require("dap").step_into()
    vim.defer_fn(function()
        require("which-key").show { keys = "<leader>d" }
    end, 150)
end, { desc = "DapStepInto" })
vim.keymap.set("n", "<leader>dh", function()
    require("dap").step_out()
    vim.defer_fen(function()
        require("which-key").show { keys = "<leader>d" }
    end, 150)
end, { desc = "DapStepOut" })
-- kms("<Leader>dr", function() require("dap").repl.open() end)
-- kms("<Leader>dl", function() require("dap").run_last() end)
-- dap }}}1

vim.keymap.set("n", "grn", function()
    vim.lsp.buf.rename()
end, { silent = true, noremap = true })
require("pairMan").setup { keymap = "<leader>p" }
wk.add {
    { "<leader>pha", proxy = "<leader>pah" },
    { "<leader>phi", proxy = "<leader>pih" },
}

CK_SetKeymap_n("<leader>D", "<CMD>Dashboard<CR>", "Dashboard")
CK_SetKeymap_n("<leader>l", "<CMD>set wrap!<CR>", "Toggles line wrap")
CK_SetKeymap_n("<leader><m-t>", "<CMD>InspectTree<CR>", "Inspect Treesitter tree")
vim.keymap.set("n", "<Up>", ":<Up>", { desc = "Previous command", silent = true, noremap = true })

require("_configs_._keybinds_._git_")
require("_configs_._keybinds_._window-nav_")
