return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        {
            "mfussenegger/nvim-dap",
            config = function()
                require("plugins.dap.configs.python")
                require("plugins.dap.configs.codelldb")
                require("plugins.dap.configs.shell")
                require("plugins.dap.keybinds")
            end,
        },
    },
    config = true,
}
