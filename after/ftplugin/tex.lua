local opt = vim.opt_local
local map = vim.keymap.set

opt.wrap = true

-- Buffer-local tweaks for TeX files
opt.spell = true
opt.spelllang = "en_us"


opt.tabstop=4
opt.sw=4
opt.linebreak=true
opt.breakindent=true

map('n', '<leader>rc', "<cmd>VimtexCompile<CR>")
