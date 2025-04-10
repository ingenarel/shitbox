return {
    "catgoose/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup {
            DEFAULT_OPTIONS = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
            },
            "*",
        }
    end,
}
