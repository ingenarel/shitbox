vim.lsp.config("bashls", {
    filetypes = { "bash", "sh" },
})
vim.lsp.enable("bashls")

local ebuildAutoCmdID
ebuildAutoCmdID = vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        ---@type vim.lsp.Config
        local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls.resolved_config) or {}
        ebuildConfig.filetypes = { "ebuild" }
        ebuildConfig.name = "bashls-ebuild"

        ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
            settings = {
                bashIde = {
                    shellcheckPath = "",
                },
            },
        })

        vim.lsp.config("bashls-ebuild", ebuildConfig)
        vim.lsp.enable("bashls-ebuild")
        vim.api.nvim_del_autocmd(ebuildAutoCmdID)
    end,
    pattern = "ebuild",
})
