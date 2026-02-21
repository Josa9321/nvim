local map = vim.keymap.set

vim.g.mapleader = " "

map('v', "J", ":m '>+1<CR>gv=gv")
map('v', "K", ":m '>-2<CR>gv=gv")


map('n', "<C-d>", '<C-d>zz')
map('n', "<C-u>", '<C-u>zz')


map('n', "n", "nzzzv")
map('n', "N", "Nzzzv")

map('x', '<leader>p', "\"_dP")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


map('n', "<C-k>", "<cmd>cnext<CR>zz")
map('n', "<C-j>", "<cmd>cprev<CR>zz")
map('n', "<leader>k", "<cmd>lnext<CR>zz")
map('n', "<leader>j", "<cmd>lprev<CR>zz")

-- Format all file according to language server
map("n", "<leader>F", function()
    vim.lsp.buf.format()
end, {})

map({"n", "i"}, "<C-s>", "<cmd>w<CR>")

-- Comunicate with clipboard only when specified
map("n", "<leader>tc", function()
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
-- map('n', '<leader>rr', ':RunCode<CR>', { noremap = true, silent = false })
-- map('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- map('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- map('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- map('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
-- map('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- map('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })


local betterTerm = require('betterTerm')


-- Open a specific terminal
map({"n", "t"}, "<C-0>", function() betterTerm.open(0) end, { desc = "Toggle terminal 0" })
map({"n", "t"}, "<C-1>", function() betterTerm.open(1) end, { desc = "Toggle terminal 1" })

-- Select a terminal to focus
map("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

-- Rename the current terminal
map("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

-- Toggle the tabs bar
map("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })

map("n", "<A-h>", "<C-w>h")
map("n", "<A-l>", "<C-w>l")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")

map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -5<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +5<cr>")

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : '<Down>'", { desc = "Down", expr = true, silent = true })
map("i", "<Down>", "<C-o>gj", { desc = "Down"})
map({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : '<Up>'", { desc = "Up", expr = true, silent = true })
map("i", "<Up>", "<C-o>gk", { desc = "Up"})

map("i", "<C-Del>", "<C-o>de")

map("i", "", "<C-o>")

map("n", "gl", "g$", { desc = "Go to end of line" })
map("n", "gh", "g^", { desc = "Go to start of line" })

map("v", "<", "<gv")
map("v", ">", ">gv")
