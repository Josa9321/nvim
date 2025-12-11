return {
    {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        "kdheepak/cmp-latex-symbols",
        {
            "micangl/cmp-vimtex",
            ft = "tex",
            config = function()
                require('cmp_vimtex').setup({})
            end,
        },
    }
}
