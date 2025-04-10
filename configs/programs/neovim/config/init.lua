---@nodoc CK_SetKeymap_n() {{{1
---@nodoc docs {{{2
---### just a wrapper around |nvim_set_keymap()|
---`noremap` and `silent` are true for normal mode
---@param keymap string keymap that you want to set it to
---@param action string stuff you want to do for the keymap
---@param description? string description for the keymap
---@nodoc docs }}}2
function CK_SetKeymap_n(keymap, action, description)
    vim.api.nvim_set_keymap("n", keymap, action, { noremap = true, silent = true, desc = description })
end -- }}}1

---@nodoc CK_SimKeys() {{{1
---@nodoc docs {{{2
---### wrapper around the |nvim_feedkeys()|
---keycodes are autoreplaced because they get feeded
---to |nvim_replace_termcodes()| first
---@param keys string keys you want to simulate
---@param flags? string default is `nt`, see |feedkeys()| for the flag info
---@nodoc docs }}}2
function CK_SimKeys(keys, flags)
    if flags == nil then
        flags = "nt"
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), flags, false)
end -- }}}1

---TODO: make this a seperate plugin
---@nodoc CK_Submap_n() {{{1
---@nodoc docs {{{2
---### creates submaps
---uses |nvim_set_keymap| for setting the keymaps
---@param keymap string keymap that you want to set it to.
---@param action string stuff you want to do for the keymap
---@param submaplevel string if your keymap is is `abcd` and you want to just hit `d` after doing `abcd` to execute the keymap again, your submaplevel would be `abc`
---@param opts? {wk: boolean?, desc:string?, wait:integer?, mode:string?} --
---`wk:` nil and true are treated the same -> it executes whichkey before executing the keymap again. if false, it doesn't
---`desc:` the description from the keymap
---`wait:` time to wait before executing the keymap again. uses |vim.wait()|
---`mode`: the mode. normal mode, visual mode, insert mode etc.
---@nodoc docs }}}2
function CK_Submap(keymap, action, submaplevel, opts)
    if opts == nil then
        opts = {}
    end

    local iswhichkey = opts.wk
    local description = opts.desc
    local waiting_time = opts.wait
    local mode = opts.mode

    ---@type string
    local whichkey = ""

    ---@type string
    local wait = ""

    if iswhichkey == true or iswhichkey == nil then
        whichkey = ":WhichKey<lt>CR>"
    end

    if waiting_time ~= nil and waiting_time >= 1 then
        wait = "vim.wait(" .. waiting_time .. ") "
    end

    if mode == nil then
        mode = "n"
    end

    vim.api.nvim_set_keymap(
        mode,
        keymap,
        action
            .. ":lua "
            .. wait
            .. "vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"
            .. whichkey
            .. submaplevel
            .. "', true, false, true), 'nt', false)<CR>",
        {
            noremap = true,
            silent = true,
            desc = description,
        }
    )
end -- }}}1

---@nodoc IGNORE_FILETYPES_ALL_FOR_CONFIG() {{{
---just returns a list of filetypes to ignore.
function IGNORE_FILETYPES_ALL_FOR_CONFIG()
    return {
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_console",
        "dap-repl",
        "dashboard",
        "mason",
        "TelescopePrompt",
        "TelescopeResults",
        "query",
    }
end -- }}}

require("_plugins_._load-plugins_")
require("_configs_._load-configs_")
require("_configs_._keybinds_._main_")
