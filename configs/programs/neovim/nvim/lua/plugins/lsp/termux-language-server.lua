vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = {
        "build.sh",
        "*.subpackage.sh",
        "PKGBUILD",
        "*.install",
        "makepkg.conf",
        "*.ebuild",
        "*.eclass",
        "color.map",
        "make.conf",
    },
    callback = function()
        vim.lsp.start {
            name = "termux",
            cmd = { "termux-language-server" },
        }
    end,
})
