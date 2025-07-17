vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "default",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                logLevel = "error",
            },
        },
    },
})
