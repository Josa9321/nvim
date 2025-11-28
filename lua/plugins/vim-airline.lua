return {
    {'vim-airline/vim-airline'},
    {
        'vim-airline/vim-airline-themes',
        dependencies = { "vim-airline/vim-airline" },
        config = function()
            vim.cmd("AirlineTheme simple")
        end,
    }
}
