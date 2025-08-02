return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        {
            "mfussenegger/nvim-dap",
            config = function()
                require("plugins.dap.configs.python")
                require("plugins.dap.configs.codelldb")
                require("plugins.dap.configs.shell")
                require("plugins.dap.keybinds")
                require("nvim-dap-virtual-text").setup { highlight_changed_variables = false, all_references = true }
            end,
        },
    },
    config = true,
}
