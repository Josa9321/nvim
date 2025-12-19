local map = vim.keymap.set

map("n", "<leader>rc",
    ":!julia --project % <CR>",
    { silent = true }
)
