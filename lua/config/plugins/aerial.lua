require("aerial").setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    --
    attach_mode = "global",
    backends = { "lsp", "treesitter", "markdown", "man" },
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
    filter_kind = {
        "Class",
        "Constructor",
        "Constant",
        "Enum",
        "Event",
        "Function",
        "Interface",
        "Module",
        "Field",
        "Method",
        "Struct",
        'Namespace',
        "Package",
    },
})

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
