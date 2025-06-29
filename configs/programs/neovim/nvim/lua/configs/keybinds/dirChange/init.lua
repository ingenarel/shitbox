vim.keymap.set("n", "<leader>cdd", function()
    vim.cmd("cd %:h | pwd ")
end, { desc = "Changes directory and shows the current dir", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cds", function()
    vim.cmd("cd ~/.config/shitbox | pwd ")
end, { desc = "Changes directory to shitbox", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnn", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/nvim | pwd ")
end, { desc = "Changes directory to nvim config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnc", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/cyberpunk-neon.nvim | pwd ")
end, { desc = "Changes directory to cyberpunk-neon.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnf", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/focus-mode.nvim | pwd ")
end, { desc = "Changes directory to focus-mode.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnl", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/luix.nvim | pwd ")
end, { desc = "Changes directory to luix.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnL", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/luse.nvim | pwd ")
end, { desc = "Changes directory to luse.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnm", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/metapack.nvim | pwd ")
end, { desc = "Changes directory to metapack.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnp", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/nvim-pairMan | pwd ")
end, { desc = "Changes directory to nvim-pairMan", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnR", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/randomtips-nvim | pwd ")
end, { desc = "Changes directory to randomtips-nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnz", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/zoxide.nvim | pwd ")
end, { desc = "Changes directory to zoxide.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnt", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/smart-term.nvim | pwd ")
end, { desc = "Changes directory to smart-term.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdnr", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/neovim/myPlugins/simple-runner.nvim | pwd ")
end, { desc = "Changes directory to simple-runner.nvim", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdwh", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/WM/hyprland/config | pwd ")
end, { desc = "Changes directory to hyprland config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdws", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/WM/sway | pwd ")
end, { desc = "Changes directory to sway config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdwr", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/WM/river | pwd ")
end, { desc = "Changes directory to river config", silent = true, noremap = true })

vim.keymap.set("n", "<leader>cdz", function()
    vim.cmd("cd ~/.config/shitbox/configs/programs/zsh/config | pwd ")
end, { desc = "Changes directory to zsh config", silent = true, noremap = true })

vim.keymap.set("n", "<F5>", function()
    vim.cmd(" MasonUpdate | Mason | Lazy clean | Lazy update ")
end, { desc = "tries to update everything", silent = true, noremap = true })
