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

-- Format all file according to language server
vim.keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format()
end, {})

-- Dashboard call
vim.keymap.set("n", "<leader>m", ":Dashboard <CR>") --

-- Comunicate with clipboard only when specified
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

-- -- RunCode Plugin
-- vim.keymap.set('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })


local betterTerm = require('betterTerm')

-- Toggle the first terminal (ID defaults to index_base, which is 0)
vim.keymap.set({"n", "t"}, "<C-l>", function() betterTerm.open() end, { desc = "Toggle terminal" })

-- Open a specific terminal
vim.keymap.set({"n", "t"}, "<C-/>", function() betterTerm.open(1) end, { desc = "Toggle terminal 1" })

-- Select a terminal to focus
vim.keymap.set("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

-- Rename the current terminal
vim.keymap.set("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

-- Toggle the tabs bar
vim.keymap.set("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })




vim.keymap.set("n", "<leader>rc",
    ":w<CR>:!clang++ % -o %:r && %:r <CR>",
    { silent = true }
)
