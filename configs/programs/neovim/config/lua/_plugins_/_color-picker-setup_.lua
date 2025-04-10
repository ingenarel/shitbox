return {
    "MarcosTypeAP/color-picker.nvim",
    config = function()
        local actions = require("color-picker.actions")
        require("color-picker").setup {
            defaults = {
                -- jump length
                jump_v = -1, -- -1 = sqrt(height)
                jump_h = -1, -- -1 = sqrt(width * 2)

                -- char used to indicate current hue
                hue_char = "|",

                -- hue step per rotation (in degrees)
                hue_step = 1,

                -- format used when inserting a new color
                format = "hex",

                -- palette mappings
                mappings = {
                    -- move one cell
                    ["k"] = actions.move_up,
                    ["j"] = actions.move_down,
                    ["h"] = actions.move_left,
                    ["l"] = actions.move_right,

                    -- move many cells
                    ["K"] = actions.jump_up,
                    ["J"] = actions.jump_down,
                    ["H"] = actions.jump_left,
                    ["L"] = actions.jump_right,

                    -- rotate hue
                    ["<m-h>"] = actions.hue_left,
                    ["<m-l>"] = actions.hue_right,

                    -- select the color under the cursor
                    ["<CR>"] = actions.select,

                    -- close the palette
                    ["q"] = actions.close,
                },
            },
        }
    end,
}
