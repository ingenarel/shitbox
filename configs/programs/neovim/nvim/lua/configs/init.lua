-- tab changes
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
-- tab changes

vim.opt.clipboard = "unnamedplus" --uses the system clipboard

vim.opt.scrolloff = 100 -- keep the scroll in the middle.

vim.opt.ignorecase = true -- Set ignorecase option

vim.opt.foldmethod = "marker"
vim.opt.foldcolumn = "auto"
vim.opt.signcolumn = "auto"
vim.opt.pumblend = 30

vim.opt.cursorline = true -- set cursorline
vim.opt.cursorcolumn = true
vim.opt.textwidth = 120

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local currentFileType = vim.opt_local.filetype._value
        if vim.list_contains(IGNORE_FILETYPES_ALL_FOR_CONFIG(), currentFileType) then
            vim.opt_local.textwidth = 0
            vim.opt_local.foldmethod = "manual"
            -- else
            --     vim.o.fileformat = "unix"
        end
        if currentFileType == "help" then
            vim.opt_local.colorcolumn = ""
        end
    end,
})

vim.opt.colorcolumn = "+0,-20,-40"
vim.opt.laststatus = 3

vim.lsp.log.set_level("ERROR")
vim.opt.mouse = ""
vim.opt.fileformats = "unix,dos"
-- vo.matchpairs = "(:),{:},[:],<:>"
vim.opt.matchpairs = "(:),{:},[:]"
vim.opt.guifont = "Hack Nerd Font:h13"

vim.filetype.add {
    extension = {
        ebuild = "ebuild",
    },
    extension = {
        hocon = "hocon",
    },
    pattern = {
        [".*/aerc/.*.conf"] = "ini",
    },
}

vim.diagnostic.config { virtual_text = { virtual_text_pos = "inline" } }

require("configs.keybinds")
