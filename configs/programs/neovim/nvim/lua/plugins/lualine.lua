return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local opts = {
            options = {
                disabled_filetypes = { "dashboard" },
            },
            sections = {
                lualine_z = {
                    "location",
                    "selectioncount",
                },
            },
        }
        if pcall(require, "noice") then
            opts.sections.lualine_x = {
                "encoding",
                "fileformat",
                "filetype",
                {
                    require("noice").api.status.mode.get,
                    cond = require("noice").api.status.mode.has,
                },
            }
        end
        require("lualine").setup(opts)
    end,
}
