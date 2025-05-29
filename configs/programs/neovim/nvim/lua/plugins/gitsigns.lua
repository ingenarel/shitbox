return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gs = require("gitsigns")
        local wk = require("which-key")
        wk.add {
            --TODO: setup get_actions() with telescope
            {
                "gsn",
                function()
                    gs.nav_hunk("next", { target = "all" })
                    vim.defer_fn(function()
                        wk.show { keys = "gs" }
                    end, 15)
                end,
                desc = "Next Git Hunk",
            },
            {
                "gsp",
                function()
                    gs.nav_hunk("prev", { target = "all" })
                    vim.defer_fn(function()
                        wk.show { keys = "gs" }
                    end, 15)
                end,
                desc = "Next Git Hunk",
            },
            {
                "gsd",
                function()
                    gs.diffthis()
                end,
                desc = "Git Diff",
            },
            {
                "gsb",
                function()
                    gs.blame_line()
                end,
                desc = "Git Blame Line",
            },
            {
                "gsB",
                function()
                    gs.blame()
                end,
                desc = "Git Blame File",
            },
            {
                "gsv",
                function()
                    gs.select_hunk()
                end,
                desc = "Git Select Hunk",
            },
            {
                "gsk",
                function()
                    gs.preview_hunk()
                end,
                desc = "Git Preview Hunk",
            },
            {
                "gsK",
                function()
                    gs.preview_hunk_inline()
                end,
                desc = "Git Preview Hunk Inline",
            },
        }
    end,
}
