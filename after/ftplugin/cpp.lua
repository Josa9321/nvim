local map = vim.keymap.set

map("n", "<leader>rc",
    ":w<CR>:!clang++ % -o %:r && %:r <CR>",
    { silent = true }
)
