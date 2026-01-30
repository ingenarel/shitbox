vim.lsp.config("bashls", {
    filetypes = { "bash", "sh" },
})
vim.lsp.enable("bashls")

local ebuildAutoCmdID
ebuildAutoCmdID = vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        print(vim.bo.filetype .. os.time())
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

-- vim.lsp.config("bashls", {
--     filetypes = { "bash", "sh" },
-- })
-- vim.lsp.enable("bashls")
--
-- -- print(vim.inspect(vim.lsp._enabled_configs.bashls))
--
-- ---@type vim.lsp.Config
-- local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls.resolved_config) or {}
-- ebuildConfig.filetypes = { "ebuild" }
-- ebuildConfig.name = "bashls-ebuild"
--
-- ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
--     settings = {
--         bashIde = {
--             shellcheckPath = "",
--         },
--     },
-- })

-- vim.defer_fn(vim.print(ebuildConfig), 3000)

-- ebuildConfig.on_attach = function()
--     print(vim.inspect(ebuildConfig))
-- end
--
-- vim.lsp.config("bashls-ebuild", ebuildConfig)
-- vim.lsp.enable("bashls-ebuild")

-- vim.lsp.config("bashls", {
--     filetypes = { "bash", "sh" },
-- })
-- vim.lsp.enable("bashls")
--
-- local ebuildAutoCmdID
-- ebuildAutoCmdID = vim.api.nvim_create_autocmd("FileType", {
--     callback = function()
--         print(vim.bo.filetype .. os.time())
--         ---@type vim.lsp.Config
--         local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls)
--         ebuildConfig.filetypes = { "ebuild" }
--         ebuildConfig.name = "bashls-ebuild"
--
--         ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
--             settings = {
--                 bashIde = {
--                     shellcheckPath = "",
--                 },
--             },
--         })
--
--         print(vim.inspect(ebuildConfig))
--
--         vim.lsp.config("bashls-ebuild", ebuildConfig)
--         vim.lsp.enable("bashls-ebuild")
--         vim.api.nvim_del_autocmd(ebuildAutoCmdID)
--     end,
--     pattern = "ebuild",
-- })

-- ---@type vim.lsp.Config
-- local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls)
-- ebuildConfig.filetypes = { "ebuild" }
-- ebuildConfig.name = "bashls-ebuild"
--
-- ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
--     settings = {
--         bashIde = {
--             shellcheckPath = "",
--         },
--     },
-- })
--
-- ebuildConfig.on_attach = function()
--     print(vim.inspect(ebuildConfig))
-- end
--
-- vim.lsp.config("bashls-ebuild", ebuildConfig)
-- vim.lsp.enable("bashls-ebuild")

-- vim.lsp.config("bashls", {
--     filetypes = { "bash", "sh", "ebuild" },
--     settings = (function()
--         local name = vim.api.nvim_buf_get_name(0)
--         if name:match("%.ebuild$") == ".ebuild" then
--             return {
--                 bashIde = {
--                     shellcheckPath = "",
--                 },
--             }
--         else
--             return {
--                 bashIde = {
--                     globPattern = "*@(.sh|.inc|.bash|.command)",
--                 },
--             }
--         end
--     end)(),
-- })
-- vim.lsp.enable("bashls")

-- print(vim.inspect(vim.lsp._enabled_configs.bashls))

-- ---@type vim.lsp.Config
-- local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls)
-- ebuildConfig.filetypes = { "ebuild" }
-- ebuildConfig.name = "bashls-ebuild"
--
-- ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
--     settings = {
--         bashIde = {
--             shellcheckPath = "",
--         },
--     },
-- })
--
-- vim.defer_fn(vim.print(ebuildConfig), 3000)

-- vim.lsp.config("bashls", {
--     filetypes = { "bash", "sh" },
-- })
-- vim.lsp.enable("bashls")
--
-- -- print(vim.inspect(vim.lsp._enabled_configs.bashls))
--
-- ---@type vim.lsp.Config
-- local ebuildConfig = vim.deepcopy(vim.lsp._enabled_configs.bashls)
-- ebuildConfig.filetypes = { "ebuild" }
-- ebuildConfig.name = "bashls-ebuild"
--
-- ebuildConfig = vim.tbl_deep_extend("force", ebuildConfig, {
--     settings = {
--         bashIde = {
--             shellcheckPath = "",
--         },
--     },
-- })
--
-- vim.defer_fn(vim.print(ebuildConfig), 3000)

-- ebuildConfig.on_attach = function()
--     print(vim.inspect(ebuildConfig))
-- end
--
-- vim.lsp.config("bashls-ebuild", ebuildConfig)
-- vim.lsp.enable("bashls-ebuild")

-- bashlsConfig.on_attach = function(_, bufNR)
--     print(vim.bo[bufNR].filetype)
--     if vim.bo[bufNR].filetype == "ebuild" then
--         bashlsConfig.settings = {
--             bashIde = {
--                 shellcheckPath = "",
--             },
--         }
--     end
-- end
--
