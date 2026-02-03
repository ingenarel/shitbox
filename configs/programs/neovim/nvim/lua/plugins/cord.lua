---@type LazySpec
return {
    "vyfor/cord.nvim",
    branch = "master",
    build = ":Cord update build",
    ---@type CordConfig
    opts = {
        plugins = {
            "diagnostics",
        },
        advanced = {
            server = {
                update = "none",
                auto_update = false,
            },
        },
    },
}
