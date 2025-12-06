local ls = require("luasnip")

ls.config.set_config({ -- Setting LuaSnip config

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Use Tab (or some other key if you prefer) to trigger visual selection
    store_selection_keys = "<Tab>",
})


vim.keymap.set({ "i" }, "<C-k>",
    function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>",
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
