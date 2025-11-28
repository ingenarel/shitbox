local m = {
    "saghen/blink.cmp",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "xzbdmw/colorful-menu.nvim",
        "onsails/lspkind.nvim",
    },
    build = "cargo +nightly build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            ["<CR>"] = { "accept", "fallback" },
            ["<M-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<M-n>"] = { "select_next", "fallback_to_mappings" },
            ["<M-h>"] = { "snippet_backward", "fallback" },
            ["<M-l>"] = { "snippet_forward", "fallback" },
            ["<M-k>"] = { "scroll_documentation_up", "fallback" },
            ["<M-j>"] = { "scroll_documentation_down", "fallback" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            documentation = { auto_show = true },
            menu = {
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local icon = ctx.kind_icon
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        icon = dev_icon
                                    end
                                else
                                    icon = require("lspkind").symbolic(ctx.kind, {
                                        mode = "symbol",
                                    })
                                end
                                return icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                local hl = ctx.kind_hl
                                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                    if dev_icon then
                                        hl = dev_hl
                                    end
                                else
                                    hl = require("colorful-menu").blink_components_highlight(ctx)
                                end
                                return hl
                            end,
                        },
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                path = {
                    opts = {
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    },
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}

return m
