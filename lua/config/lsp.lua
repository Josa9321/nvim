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
        { name = 'nvim_lsp_signature_help' }
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

cmp.setup.filetype("txt", {
    sources = {
        { name = 'luasnip' },
        { name = 'path' },
    },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Languages Servers
-- Markdown
vim.lsp.config.marksman = {
    cmd = { "/home/josa/Apps/marksman-linux-x64", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
    capabilities = capabilities,
}

vim.lsp.enable("marksman")

-- Lua
vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { "lua" },
    root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
    capabilities = capabilities,

    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            completion = { callSnippet = "both" }
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

local function get_python_path()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    if venv then
        return venv .. "/bin/python"
    end
    return "~/anaconda3/bin/python"
end

-- Define the configuration
vim.lsp.config.basedpyright = {
    capabilities = capabilities,
    cmd = { vim.fn.expand("~/anaconda3/bin/basedpyright-langserver"), "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git", "requirements.txt" },
    settings = {
        basedpyright = {
            pythonPath = get_python_path(),
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
            typeCheckingMode = "standard",
        },
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
vim.lsp.config('julials', {
    cmd = {
        "julia",
        "--startup-file=no",
        "--history-file=no",
        "-e", [[
                using Revise
                using LanguageServer
                using Pkg

                import StaticLint
                import SymbolServer

                env_path = dirname(Pkg.Types.Context().env.project_file)
                server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
                server.runlinter = true;
                run(server)
            ]]
    },
    filetypes = { 'julia' },
    root_markers = { "Project.toml", "JuliaProject.toml" },
    settings = {}
})
vim.lsp.enable("julials")
-- vim.lsp.config.julia = {
--     cmd = {
--         'julia', '--project', '--startup-file=no', '--history-file=no', '-e', [[
--             using Revise
--             using LanguageServer;
--             using Pkg;
--
--             server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
--             server.runlinter = true;
--             run(server);
--         ]]
--     },
--     filetypes = { "julia" },
--     capabilities = capabilities,
--     settings = {
--       julia = {
--         completion = {
--           callSnippet = 'Replace',
--         },
--       },
--     },
-- }
--
-- vim.lsp.enable("julia")

-- R Program

vim.lsp.config.R = {
    cmd = {
        'R', '--no-echo', '-e', '"languageserver::run()"' },
    filetypes = { "R" },
    capabilities = capabilities,
}

vim.lsp.enable("R")

-- LaTeX
local texlab_capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocumentBuild = { dynamicRegistration = false },
    textDocumentForwardSearch = { dynamicRegistration = false },
})
local executable = 'zathura'
local args_tex = {
    '--synctex-editor-command',
    [[nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]] .. vim.v.servername,
    '--synctex-forward',
    '%l:1:%f',
    '%p',
}
vim.lsp.config.texlab = {
    cmd = { "texlab" },
    filetypes = { "tex", "bib", "latex" },
    capabilities = texlab_capabilities,
    settings = {
        texlab = {
            build = {
                auxDirectory = "build",
                executable = "tectonic",
                args = {
                    "-X",
                    "compile",
                    "--synctex",
                    "-Z", "shell-escape",
                    "%f",
                },
                onSave = false,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = executable,
                args = args_tex, --{ "--synctex-forward", "%l:1:%f", "%p" },
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

-- WEB DEVELOPMENT

-- vim.lsp.config.biome = {
--     cmd = { "biome", "lsp-proxy" },
--     filetypes = { "astro", "css", "graphql", "html", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescriptreact", "vue" },
--     root_markers = { "biome.json", "biome.jsonc", ".git" },
--     capabilities = capabilities,
-- }
-- vim.lsp.enable('biome')

-- HTML
vim.lsp.config.html = {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html" },
    root_markers = { ".git" },
}

vim.lsp.enable("html")

-- CSS
vim.lsp.config.cssls = {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css" },
    root_markers = { ".git" },
}

vim.lsp.enable("cssls")

-- JavaScript / TypeScript
vim.lsp.config.ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_markers = { "package.json", "tsconfig.json", ".git" },
}

vim.lsp.enable("ts_ls")
