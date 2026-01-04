local map = vim.keymap.set

map("n", "<leader>rc",
    ":w<CR>:!clang++ % -g -o %:r && %:r <CR>",
    { silent = true }
)
