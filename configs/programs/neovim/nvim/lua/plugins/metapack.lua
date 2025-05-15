local m = {
    "ingenarel/metapack.nvim",
    branch = "dev",

    dependencies = {
        {
            "williamboman/mason.nvim",
            config = true,
        },
        require("plugins.luix"),
        require("plugins.luse"),
    },
    config = function()
        require("metapack").setup {
            nixOutputFile = "~/.config/nixos-config/configs/programs/neovim/metapack.nix",
            nixFlakeDir = "~/.config/nixos-config",
            ensure_installed = {
                --lsp
                "pyright",
                "clangd",
                "lua-language-server",
                "bash-language-server",
                "termux-language-server",
                "ltex-ls-plus",
                "yaml-language-server",
                "rust-analyzer",
                --lsp
                --dap
                "codelldb",
                "debugpy",
                "bash-debug-adapter",
                --dap
                --formatter
                "black",
                "stylua",
                "clang-format",
                "beautysh",
                "nil",
                "alejandra",
                --formatter
            },
        }
    end,
}
if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/metapack.nvim")) ~= nil then
    m.dir = "~/coding/git/metapack.nvim"
end

return m
