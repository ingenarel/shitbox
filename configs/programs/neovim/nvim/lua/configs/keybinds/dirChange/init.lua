vim.keymap.set("n", "<leader>cdd", function()
    vim.cmd("cd %:h | pwd ")
end, { desc = "Changes directory and shows the current dir", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cds", function()
    vim.cmd("cd ~/.config/shitbox | pwd ")
end, { desc = "Changes directory to shitbox", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdn", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/nvim | pwd ")
end, { desc = "Changes directory to nvim config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdh", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/hyprland/config | pwd ")
end, { desc = "Changes directory to hyprland config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdh", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/hyprland/config | pwd ")
end, { desc = "Changes directory to hyprland config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdz", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/zsh/config | pwd ")
end, { desc = "Changes directory to zsh config", silent = true, noremap = true })

vim.keymap.set("n", "<F5>", function()
    vim.cmd(" MasonUpdate | Mason | Lazy clean | Lazy update ")
end, { desc = "tries to update everything", silent = true, noremap = true })
