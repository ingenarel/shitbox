--TODO: make this a seperate plugin
vim.keymap.set( -- runner {{{1
    "n",
    "<leader>r",
    function()
        local current_filetype = vim.bo.filetype

        local function floating_terminal(title, stuff)
            vim.cmd(
                "FloatermNew --width=1.0 --height=0.95 --title="
                    .. title
                    .. " --titleposition=center --autoclose=0 "
                    .. stuff
            )
        end

        vim.cmd("w")

        local file_with_extension = vim.fn.expand("%:p")
        local file_without_extension = vim.fn.fnamemodify(file_with_extension, ":r")

        local function execute_with(title, program)
            floating_terminal(title, program .. ' "' .. file_with_extension .. '"')
        end

        if current_filetype == "python" then
            execute_with(current_filetype, current_filetype)
        elseif current_filetype == "sh" then
            floating_terminal(current_filetype, file_with_extension)
        elseif current_filetype == "c" then
            -- if using windows, make sure you set your CC variable
            -- i set it to `gcc -Wall -Wextra`
            -- local linuxbin = "./"
            -- if vim.fn.has("win32") == 1 then
            --     linuxbin = ""
            -- end
            floating_terminal(
                current_filetype,
                -- 'make "' .. file_without_extension .. '" && ' .. linuxbin .. '"' .. file_without_extension .. '"'
                'make "'
                    .. file_without_extension
                    .. '" && '
                    .. '"'
                    .. file_without_extension
                    .. '"'
            )
        elseif current_filetype == "lua" then
            execute_with(current_filetype, current_filetype)
        elseif current_filetype == "dosbatch" then
            floating_terminal("batch", "cmd /c % && exit")
        elseif current_filetype == "ps1" then
            execute_with("powershell", "powershell -File ")
        elseif current_filetype == "html" then -- change it to your browser, make sure the browser is on the path
            vim.cmd('!librewolf "' .. file_with_extension .. '"')
        else
            vim.notify("Filetype hasn't been implemented yet", "WARN")
        end
    end,
    { desc = "Try to run current file", silent = true, noremap = true }
) -- }}}1
