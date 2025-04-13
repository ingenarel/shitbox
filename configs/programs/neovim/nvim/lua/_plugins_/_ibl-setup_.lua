return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }
        local hooks = require("ibl.hooks")

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ff0055" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f4ef00" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#76c1ff" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FF8F26" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#00FF3A" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#00ffc8" })
        end)

        require("ibl").setup {
            exclude = { filetypes = { "dashboard" } },
            indent = { highlight = highlight, char = "▏" },
        }
    end,
}
