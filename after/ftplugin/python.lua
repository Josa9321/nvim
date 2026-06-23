local map = vim.keymap.set

map("n", "<leader>rc",
    ":!python % <CR>",
    { silent = true }
)

vim.keymap.set("n", "<leader>Fp", function()
    vim.cmd("w")
    vim.cmd("!~/anaconda3/bin/black %")
end, { desc = "Format Python file with Black" })
