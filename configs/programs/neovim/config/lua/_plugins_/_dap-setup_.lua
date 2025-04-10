return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "nvim-neotest/nvim-nio",
        {
            "mfussenegger/nvim-dap",
            config = function()
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
                            command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
                            args = { "-m", "debugpy.adapter" },
                            options = {
                                source_filetype = "python",
                            },
                        }
                    end
                end
                dap.adapters.codelldb = {
                    type = "server",
                    port = "${port}",
                    executable = {
                        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                        args = { "--port", "${port}" },
                        detached = false,
                    },
                }
                dap.adapters.bashdb = {
                    type = "executable",
                    command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
                    name = "bashdb",
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
                dap.configurations.python = {
                    {
                        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
                        request = "launch",
                        name = "Launch file",
                        program = "${file}", -- This configuration will launch the current file if used.
                        pythonPath = "python",
                    },
                }
                dap.configurations.sh = {
                    {
                        type = "bashdb",
                        request = "launch",
                        name = "Launch file",
                        showDebugOutput = true,
                        pathBashdb = vim.fn.stdpath("data")
                            .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
                        pathBashdbLib = vim.fn.stdpath("data")
                            .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
                        trace = true,
                        file = "${file}",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        pathCat = "cat",
                        pathBash = "/bin/bash",
                        pathMkfifo = "mkfifo",
                        pathPkill = "pkill",
                        args = {},
                        env = {},
                        terminalKind = "integrated",
                    },
                }
            end,
        },
    },
    config = true,
}
