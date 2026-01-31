---@type LazySpec
return {
    "mfussenegger/nvim-lint",
    config = function()
        local severities = {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            info = vim.diagnostic.severity.INFO,
            style = vim.diagnostic.severity.HINT,
        }
        local function shellcheck_ebuild_custom_file()
            local exportedFileDir =
                vim.fs.joinpath(vim.fn.stdpath("cache"), "shellcheck_ebuild", vim.fn.expand("%:p:h"))
            vim.fn.mkdir(exportedFileDir, "p")
            local exportedFilePath = vim.fs.joinpath(exportedFileDir, vim.fn.expand("%:t"))
            local mainfile = io.open(vim.fn.expand("%:p"), "r")
            local fileContent
            if mainfile ~= nil then
                fileContent = mainfile:read("*a")
                mainfile:close()
            end
            local exportedFile = io.open(exportedFilePath, "w")
            if exportedFile ~= nil then
                exportedFile:write(fileContent .. "\n" .. require("plugins.nvim-lint.shellcheck_ebuild.ebuild-vars"))
                exportedFile:close()
            end
            return exportedFilePath
        end
        require("lint").linters.shellcheck_ebuild = {
            name = "shellcheck_ebuild",
            cmd = "shellcheck",
            stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
            append_fname = false, -- Automatically append the file name to `args` if `stdin = false` (default: true)
            args = {
                "--shell",
                "bash",
                "--format",
                "json1",
                shellcheck_ebuild_custom_file,
            }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
            ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
            env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
            parser = function(output)
                if output == "" then
                    return {}
                end
                local decoded = vim.json.decode(output)
                local diagnostics = {}
                for _, item in ipairs(decoded.comments or {}) do
                    table.insert(diagnostics, {
                        lnum = item.line - 1,
                        col = item.column - 1,
                        end_lnum = item.endLine - 1,
                        end_col = item.endColumn - 1,
                        code = item.code,
                        source = "shellcheck_ebuild",
                        user_data = {
                            lsp = {
                                code = item.code,
                            },
                        },
                        severity = assert(severities[item.level], "missing mapping for severity " .. item.level),
                        message = item.message,
                    })
                end
                return diagnostics
            end,
        }
        require("lint").linters_by_ft = {
            ebuild = { "shellcheck_ebuild" },
        }
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
