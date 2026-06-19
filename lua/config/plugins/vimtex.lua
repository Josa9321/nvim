vim.g.vimtex_compiler_method = 'tectonic'
vim.g.vimtex_compiler_tectonic = {
    build_dir = '',
    hooks = {},
    options = {
        '--keep-logs',
        '--synctex',
        '--keep-intermediates',
        '-Z', 'continue-on-errors',
    },
}

-- Recompile on every save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.tex',
    callback = function()
        vim.cmd('VimtexCompile')
    end,
})
