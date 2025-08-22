local function createAutocmd()
    return vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            if vim.bo.filetype ~= "ebuild" then
                require("conform").format { bufnr = args.buf }
            end
            pcall(function()
                if vim.opt_local.commentstring:get() ~= "" then
                    vim.cmd("%s/\\(\\S\\)\\(" .. string.sub(vim.opt.commentstring._value, 1, -3) .. "...\\)/\\1 \\2/g")
                end
            end)
        end,
    })
end

return {
    "stevearc/conform.nvim",
    config = function()
        local conform = require("conform")
        conform.formatters.beautysh = {
            prepend_args = function()
                if vim.opt_local.filetype._value == "ebuild" then
                    return { "-t" }
                end
                return {}
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
        local autocmdID = createAutocmd()
        vim.api.nvim_create_user_command("ConformEnable", function()
            autocmdID = createAutocmd()
        end, {})
        vim.api.nvim_create_user_command("ConformDisable", function()
            vim.api.nvim_del_autocmd(autocmdID)
        end, {})
    end,
}
