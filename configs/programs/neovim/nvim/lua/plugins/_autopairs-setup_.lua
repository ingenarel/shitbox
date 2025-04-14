return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local remap = vim.api.nvim_set_keymap
        -- local Rule = require("nvim-autopairs.rule")
        local npairs = require("nvim-autopairs")

        npairs.setup {
            check_ts = true,
            map_bs = false,
            map_cr = false,
            disable_in_visualblock = true,
            enable_moveright = false,
            disable_filetype = {},
            enable_check_bracket_line = false,
        }

        -- npairs.add_rules{
        --     Rule("<", ">")
        -- }

        -- skip it, if you use another global object
        _G.MUtils = {}

        MUtils.CR = function()
            if vim.fn.pumvisible() ~= 0 then
                if vim.fn.complete_info({ "selected" }).selected ~= -1 then
                    return npairs.esc("<c-y>")
                else
                    return npairs.esc("<c-e>") .. npairs.autopairs_cr()
                end
            else
                return npairs.autopairs_cr()
            end
        end
        remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

        MUtils.BS = function()
            if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
                return npairs.esc("<c-e>") .. npairs.autopairs_bs()
            else
                return npairs.autopairs_bs()
            end
        end
        remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
    end,
}
