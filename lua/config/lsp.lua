local cmp = require("cmp")
local luasnip = require("luasnip")


cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
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

        ["<C-n>"] = cmp.mapping(function(fallback)
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

        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'buffer' },
        { name = 'path' },
        { name = "latex_symbols" },
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
        { name = 'nvim_lsp' },
        { name = 'vimtex' },
        { name = 'luasnip' },
        { name = 'path' },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

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
            completion = {callSnippet = "both"}
        }
    }
}

vim.lsp.enable("lua_ls")

-- Python
-- vim.lsp.config.pyright = {
--     cmd = {
--         'pyright-langserver',
--         "--stdio",
--     },
--     filetypes = { "python" },
--     capabilities = capabilities,
-- }
-- vim.lsp.enable("pyright")

-- Define the configuration
vim.lsp.config.basedpyright = {
    capabilities = capabilities,
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git", "requirements.txt" },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
        python = {
            pythonPath = "~/anaconda3/bin/python",
            completion = {callSnippet = "Replace"}
        }
    }
}
vim.lsp.enable("basedpyright")

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
        'julia', '--project', '--startup-file=no', '--history-file=no', '-e', [[
            using Revise
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
    settings = {
      julia = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
}

vim.lsp.enable("julia")

-- R Program

vim.lsp.config.R = {
    cmd = {
        'R', '--no-echo', '-e', '"languageserver::run()"' },
    filetypes = { "R" },
    capabilities = capabilities,
}

vim.lsp.enable("R")


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
                onSave = false,
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
