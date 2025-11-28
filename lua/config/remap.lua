vim.g.mapleader = " "

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '>-2<CR>gv=gv")


vim.keymap.set('n', "<C-d>", '<C-d>zz')
vim.keymap.set('n', "<C-u>", '<C-u>zz')


vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")

vim.keymap.set('x', '<leader>p', "\"_dP")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


vim.keymap.set('n', "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set('n', "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set('n', "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set('n', "<leader>j", "<cmd>lprev<CR>zz")

vim.g.netrw_liststyle = 3
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
    end,
})


