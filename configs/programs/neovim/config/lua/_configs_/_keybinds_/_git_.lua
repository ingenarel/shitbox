CK_SetKeymap_n(
    "<leader>gg",
    ":FloatermNew --width=0.97 --height=0.97 --title=LAZYGIT --titleposition=center lazygit<CR>",
    "Lazygit"
)
CK_SetKeymap_n("<leader>ga", ":!git add %", "Add current file to git")
CK_SetKeymap_n("<leader>gA", ":!git add -A<CR>", "Add all files to git")
CK_SetKeymap_n("<leader>gr", ":!git reset %<CR>", "Git reset")

---@nodoc CK_GitWrapperCommit() {{{1
---@nodoc docs {{{2
--- ### it's just a wrapper around git's commit
---@param add ("current"|"all")? if `nil`, don't add files before committing
---if `current` add the current file before committing
---if `all`, add all files before committing
---@nodoc }}}2
function CK_GitWrapperCommit(add)
    local commit_msg = vim.fn.input("Commit msg")

    if commit_msg == "" then
        return 0
    end

    local commit_desc = vim.fn.input("Commit desc")

    vim.cmd("w")

    if add == "current" then
        vim.cmd("!git add %")
    elseif add == "all" then
        vim.cmd("!git add -A")
    end

    if commit_desc ~= nil then
        vim.cmd('!git commit -m "' .. commit_msg .. '"')
    else
        vim.cmd('!git commit -m "' .. commit_msg .. '" -m "' .. commit_desc .. '"')
    end
end -- }}}1

vim.keymap.set("n", "<leader>gcc", function()
    CK_GitWrapperCommit()
end, { desc = "Commits without trying to add files" })
vim.keymap.set("n", "<leader>gca", function()
    CK_GitWrapperCommit("current")
end, { desc = "Adds the current file and commits" })
vim.keymap.set("n", "<leader>gcA", function()
    CK_GitWrapperCommit("all")
end, { desc = "Adds all files and commits" })
