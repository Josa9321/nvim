local opt = vim.opt

opt.wrap = true

-- Buffer-local tweaks for TeX files
vim.opt_local.conceallevel = 2 -- keep math pretty but text readable
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
