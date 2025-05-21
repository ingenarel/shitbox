return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.formatters.beautysh = {
            prepend_args = function()
                if vim.opt_local.filetype._value == "ebuild" then
                    return { "-t" }
                end
            end,
        }
        conform.formatters.jq = {
            prepend_args = { "--indent", "4" },
        }

        conform.setup {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                c = { "clang-format" },
                bash = { "beautysh" },
                csh = { "beautysh" },
                ksh = { "beautysh" },
                zsh = { "beautysh" },
                sh = { "beautysh" },
                ebuild = { "beautysh" },
                nix = { "alejandra" },
                json = { "jq" },
            },
        }

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format { bufnr = args.buf }
                pcall(function()
                    if vim.opt_local.commentstring._value ~= "" then
                        vim.cmd("%s/\\(\\S\\)\\(" .. vim.opt.commentstring._value .. " ...\\)/\\1 \\2/g")
                    end
                end)
            end,
        })
    end,
}
