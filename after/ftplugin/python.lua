local map = vim.keymap.set

map("n", "<leader>rc",
    ":!python % <CR>",
    { silent = true }
)
