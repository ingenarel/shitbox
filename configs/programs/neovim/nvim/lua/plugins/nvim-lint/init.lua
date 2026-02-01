---@type LazySpec
return {
    "ingenarel/nvim-lint",
    branch = "shellcheck_ebuild",
    config = function()
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
