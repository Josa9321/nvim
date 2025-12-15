vim.o.rnu = true
vim.o.nu = true

vim.opt.formatoptions:remove({ "c", "r", "o" })

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.cursorline = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:2"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "



vim.g.vimtex_compiler_method = "tectonic"
