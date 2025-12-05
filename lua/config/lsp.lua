local cmp = require("cmp")
local luasnip = require("luasnip")


cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<C-g>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

cmp.setup.filetype("tex", {
    sources = {
        { name = 'vimtex' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Languages Servers

-- Lua
vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
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

-- Python
vim.lsp.config.pyright = {
    cmd = {
        'pyright-langserver',
        "--stdio",
    },
    filetypes = { "python" },
    capabilities = capabilities,
}

vim.lsp.enable("pyright")

-- Cpp
vim.lsp.config.clangd = {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--log=verbose",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_markers = { ".clangd", "compile_commands.json" },
    capabilities = capabilities,
}

vim.lsp.enable("clangd")

-- Julia
vim.lsp.config.julia = {
    cmd = {
        -- 'julia --project -e "using LanguageServer; runserver()"',
        'julia', '--project', '--startup-file=no', '--history-file=no', '-e', [[
            using LanguageServer;
            using Pkg;
            import StaticLint;
            import SymbolServer;
            env_path = dirname(Pkg.Types.Context().env.project_file);

            server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
            server.runlinter = true;
            run(server);
        ]]
    },
    filetypes = { "julia" },
    capabilities = capabilities,
}

vim.lsp.enable("julia")

-- LaTeX
vim.lsp.config.texlab = {
    cmd = { "texlab" },
    filetypes = { "tex", "bib", "latex" },
    settings = {
        texlab = {
            build = {
                auxDirectory = "build",
                executable = "tectonic",
                args = {
                    "-X", "compile",
                    "%f",
                    "--synctex",
                    "--keep-logs",
                    "--keep-intermediates"
                },
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            chktex = { onOpenAndSave = true, onEdit = false },
            bibtexFormatter = "latexindent",
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    }
}

vim.lsp.enable('texlab')
