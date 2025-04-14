local dap = require("dap")
dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb {
            type = "server",
            port = assert(port, "`connect.port` is required for a python `attach` configuration"),
            host = host,
            options = {
                source_filetype = "python",
            },
        }
    else
        cb {
            type = "executable",
            -- command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
            -- args = { "-m", "debugpy.adapter" },
            command = "python",
            -- command = "debugpy",
            args = { "-Xfrozen_modules=off", "-m", "debugpy.adapter" },
            -- args = { "-Xfrozen_modules=off" },
            options = {
                source_filetype = "python",
            },
        }
    end
end

dap.configurations.python = {
    {
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = "python",
    },
}
