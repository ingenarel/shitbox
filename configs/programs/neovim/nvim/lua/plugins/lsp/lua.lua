vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- library = table.insert(vim.api.nvim_get_runtime_file("", true), "${3rd}/luv/library")
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                    vim.fn.stdpath("data") .. "/lazy",
                    -- "${3rd}/busted/library",
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
