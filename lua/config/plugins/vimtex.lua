vim.g.vimtex_syntax_enabled = 1       -- keep syntax
vim.g.vimtex_compiler_enabled = 0     -- let texlab/tectonic handle builds
vim.g.vimtex_view_method = "zathura"  -- still handles inverse search nicely

-- vim.g.vimtex_compiler_method = 'tectonic'
-- vim.g.vimtex_compiler_tectonic = {
--     build_dir = '',
--     hooks = {},
--     options = {
--         '--keep-logs',
--         '--synctex',
--         '-Z', 'continue-on-errors',
--     },
-- }

-- -- Recompile on every save
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     pattern = '*.tex',
--     callback = function()
--         vim.cmd('VimtexCompile')
--     end,
-- })
