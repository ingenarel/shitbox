local dap = require("dap")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.exepath("codelldb"),
        args = { "--port", "${port}" },
        detached = false,
    },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            local outputBin = vim.fn.expand("%:p:r") .. "-debug"
            local run = vim.system({
                "cc",
                "-g",
                vim.fn.expand("%:p"),
                "-o",
                outputBin,
            }):wait()
            if run.code ~= 0 then
                vim.print(run)
                error("Failed to compile file")
            end
            return outputBin
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
