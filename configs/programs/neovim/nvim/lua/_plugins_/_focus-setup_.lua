local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(_)
        if vim.list_contains(IGNORE_FILETYPES_ALL_FOR_CONFIG(), vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = "Disable focus autoresize for FileType",
})

return {
    "nvim-focus/focus.nvim",
    version = false,
    config = {
        enable = true, -- Enable module
        commands = true, -- Create Focus commands
        autoresize = {
            enable = true, -- Enable or disable auto-resizing of splits
            minwidth = 10, -- Force minimum width for the unfocused window
            minheight = 7, -- Force minimum height for the unfocused window
        },
        ui = {
            hybridnumber = true, -- Display hybrid line numbers in the focussed window only
            cursorline = true, -- Display a cursorline in the focussed window only
            cursorcolumn = true, -- Display cursorcolumn in the focussed window only
            signcolumn = true, -- Display signcolumn in the focussed window only
            colorcolumn = {
                enable = true, -- Display colorcolumn in the foccused window only
                list = "+0,-20,-40", -- Set the comma-saperated list for the colorcolumn
            },
            -- TODO: fix the window highlighting. this doesn't work, need to probably open a github issue about it.
            -- make sure i update everything and update this plugin too before i open an issue
            -- winhighlight = true, -- Auto highlighting for focussed/unfocussed windows
        },
    },
}
