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
