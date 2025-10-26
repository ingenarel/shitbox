local m = {
    "ms-jpq/coq_nvim",
    branch = "coq",
    init = function()
        vim.g.coq_settings = {
            auto_start = "shut-up",
            keymap = {
                eval_snips = "<leader>cs",
                recommended = false,
                jump_to_mark = "<M-h>",
            },
            display = {
                preview = {
                    resolve_timeout = 1,
                },
                mark_applied_notify = false,
            },
        }
    end,
}

return m
