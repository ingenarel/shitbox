vim.lsp.enable("lua_ls")

vim.lsp.config("lua_ls", {
    on_init = function(client)
        -- if client.workspace_folders then
        --     local path = client.workspace_folders[1].name
        --     if
        --         path ~= vim.fn.stdpath("config")
        --         and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        --     then
        --         return
        --     end
        -- end

        local config = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                telemetry = {
                    enable = false,
                },
            },
        }

        local cwd = vim.fn.expand("%")
        if string.find(cwd, "nvim") or string.find(cwd, "neovim") then
            config = vim.tbl_deep_extend("force", config, {
                runtime = {
                    path = {
                        "lua/?.lua",
                        "lua/?/init.lua",
                    },
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        -- library = table.insert(vim.api.nvim_get_runtime_file("", true), "${3rd}/luv/library")
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
                        vim.fn.stdpath("data") .. "/lazy",
                        -- "${3rd}/busted/library",
                    },
                },
            })
        --TODO:  figure out how to load weechat libs in lua-language-server
        elseif string.find(cwd, "weechat") then
            config = vim.tbl_deep_extend("force", config, {
                diagnostics = {
                    globals = { "weechat" },
                },
                -- runtime = {
                --     -- cpath = {
                --     --     "/lib64/weechat/plugins/lua.so",
                --     -- },
                --     -- path = {
                --     --     "/lib64/weechat/plugins/lua.so",
                --     -- },
                -- },
                workspace = {
                    library = {
                        "/lib64/weechat/plugins/lua.so",
                    },
                },
            })
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, config)
    end,
    settings = {
        Lua = {},
    },
})
