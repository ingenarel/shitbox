return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup {
            options = {
                disabled_filetypes = { "dashboard" },
            },
            sections = {
                lualine_z = {
                    "location",
                    "selectioncount",
                },
                lualine_x = {
                    {
                        require("noice").api.status.mode.get,
                        cond = require("noice").api.status.mode.has,
                    },
                },
            },
        }
    end,
}
