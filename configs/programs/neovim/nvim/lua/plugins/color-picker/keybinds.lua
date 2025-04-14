local picker = require("color-picker")
local wk = require("which-key")
local sizes = { 2, 3, 4, 5, 6, 7, 8, 9 }
for i = 1, #sizes do
    wk.add {
        {
            "<leader>cpr" .. sizes[i],
            function()
                picker.replace { width = sizes[i] * 20, height = sizes[i] * 10 }
            end,
        },
        {
            "<leader>cpi" .. sizes[i],
            function()
                picker.insert { width = sizes[i] * 20, height = sizes[i] * 10 }
            end,
        },
    }
end

wk.add {
    { "<leader>cpRh", "<CMD>ColorPickerReformat hex<CR>" }, -- color picker reformat hex
    { "<leader>cpRr", "<CMD>ColorPickerReformat rgb<CR>" }, -- color picker reformat rgb
    { "<leader>cpRa", "<CMD>ColorPickerReformat rgba<CR>" }, -- color picker reformat rgba
}
