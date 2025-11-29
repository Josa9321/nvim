local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
})

-- Search (`/` and `?`)
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    }
})

-- `:` cmdline
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})


cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})


local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.lua_ls = {
    cmd = { "/data/data/com.termux/files/usr/bin/lua-language-server" },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    capabilities = capabilities,

    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
        }
    }
}

vim.lsp.enable("lua_ls")


vim.lsp.config.pyright = {
    cmd = {
        "/data/data/com.termux/files/usr/bin/pyright-langserver",
        "--stdio",
    },
    filetypes = { "python" },
    capabilities = capabilities,
}

vim.lsp.enable("pyright")


vim.lsp.config.clangd = {
    cmd = {
        "/data/data/com.termux/files/usr/bin/clangd",
        "--background-index",
        "--clang-tidy",
        "--log=verbose",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".clangd", "compile_commands.json" },
    capabilities = capabilities,
}

vim.lsp.enable("clangd")


-- -- Set up nvim-cmp.
-- local cmp = require('cmp')
--
-- cmp.setup({
--     snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--             -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--             -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--             -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--             -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--
--             -- For `mini.snippets` users:
--             -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
--             -- insert({ body = args.body }) -- Insert at cursor
--             -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
--             -- require("cmp.config").set_onetime({ sources = {} })
--         end,
--     },
--     window = {
--         -- completion = cmp.config.window.bordered(),
--         -- documentation = cmp.config.window.bordered(),
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         -- { name = 'vsnip' }, -- For vsnip users.
--         { name = 'luasnip' }, -- For luasnip users.
--         -- { name = 'ultisnips' }, -- For ultisnips users.
--         -- { name = 'snippy' }, -- For snippy users.
--     }, {
--         { name = 'buffer' },
--     })
-- })
--
-- -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- -- Set configuration for specific filetype.
-- --[[ cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'git' },
--     }, {
--         { name = 'buffer' },
--     })
-- })
-- require("cmp_git").setup() ]]--
--
-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--         { name = 'cmdline' }
--     }),
--     matching = { disallow_symbol_nonprefix_matching = false }
-- })
--
-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
--
-- -- lua lang
--
-- vim.lsp.config['lua_ls'] = {
--       -- Command and arguments to start the server.
--     cmd = { '/data/data/com.termux/files/usr/bin/lua-language-server' },
--     -- Filetypes to automatically attach to.
--     filetypes = { 'lua' },
--     -- Sets the "workspace" to the directory where any of these files is found.
--     -- Files that share a root directory will reuse the LSP server connection.
--     -- Nested lists indicate equal priority, see |vim.lsp.Config|.
--     root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
--     -- Specific settings to send to the server. The schema is server-defined.
--     -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
--     capabilities=capabilities,
--     settings = {
--         Lua = {
--             runtime = {
--                 version = 'LuaJIT',
--             }
--         }
--     }
-- }
-- vim.lsp.enable('lua_ls')
--
--
-- -- python lang
-- vim.lsp.config("pyright", {
--     cmd = {
--         "/data/data/com.termux/files/usr/bin/pyright-langserver",
--         "--stdio",
-- 	},
--     capabilities=capabilities,
--     filetypes = {'python'}
-- })
--
--
-- vim.lsp.enable("pyright")
--
--
-- -- cpp lang
-- vim.lsp.config("clangd", {
--     cmd = {
--         "/data/data/com.termux/files/usr/bin/clangd",
--         '--background-index', '--clang-tidy', '--log=verbose'
-- 	},
--     root_markers = { '.clangd', 'compile_commands.json' },
--     capabilities=capabilities,
--     filetypes = {'c', 'cpp', 'h', 'hpp'}
-- })
--
--
-- vim.lsp.enable("clangd")
--
--
