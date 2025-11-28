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

vim.keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format()
end, {})

vim.keymap.set("n", "<leader>m", ":Dashboard <CR>") --

vim.keymap.set("n", "<leader>tc", function()
    local cb = vim.opt.clipboard:get()

    -- check if unnamedplus is active in the list
    local hasUnnamedPlus = false
    for _, v in ipairs(cb) do
        if v == "unnamedplus" then
            hasUnnamedPlus = true
        end
    end

    if hasUnnamedPlus then
        vim.opt.clipboard = {}
        print("Clipboard: DISABLED")
    else
        vim.opt.clipboard = { "unnamedplus" }
        print("Clipboard: ENABLED (unnamedplus)")
    end
end, { desc = "Toggle clipboard" })
