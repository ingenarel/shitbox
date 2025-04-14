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

require("plugins._load-plugins_")
require("_configs_._load-configs_")
require("_configs_._keybinds_._main_")
