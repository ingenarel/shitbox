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
            nixOutputFile = os.getenv("HOME") .. "/.config/nixos-config/configs/programs/neovim/metapack.nix",
            nixFlakeDir = os.getenv("HOME") .. "/.config/nixos-config",
            ensure_installed = {
                --lsp
                { gentoo = { "pyright" }, default = "pyright" },
                { gentoo = { "clangd", mason = true }, default = "clangd" },
                "lua-language-server",
                { gentoo = { "bash-language-server" }, default = "bash-language-server" },
                "termux-language-server",
                "ltex-ls-plus",
                { gentoo = { "yaml-language-server" }, default = "yaml-language-server" },
                "rust-analyzer",
                { gentoo = { "json-lsp" }, default = "json-lsp" },
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
                { gentoo = { "nil" }, default = "nil" },
                "alejandra",
                "jq",
                --formatter
            },
        }
    end,
}
if vim.uv.fs_stat(vim.fs.normalize("~/coding/git/metapack.nvim")) ~= nil then
    m.dir = "~/coding/git/metapack.nvim"
end

return m
