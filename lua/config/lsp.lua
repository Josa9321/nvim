vim.lsp.config['lua_ls'] = {
      -- Command and arguments to start the server.
    cmd = { '/data/data/com.termux/files/usr/bin/lua-language-server' },
    -- Filetypes to automatically attach to.
    filetypes = { 'lua' },
    -- Sets the "workspace" to the directory where any of these files is found.
    -- Files that share a root directory will reuse the LSP server connection.
    -- Nested lists indicate equal priority, see |vim.lsp.Config|.
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    -- Specific settings to send to the server. The schema is server-defined.
    -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
}
vim.lsp.enable('lua_ls')


-- python lang
vim.lsp.config("pyright", {
    cmd = {
        "/data/data/com.termux/files/usr/bin/pyright-langserver",
        "--stdio",
	},
    filetypes = {'python'}
})


vim.lsp.enable("pyright")


-- cpp lang
vim.lsp.config("clangd", {
    cmd = {
        "/data/data/com.termux/files/usr/bin/clangd",
        '--background-index', '--clang-tidy', '--log=verbose'
	},
    root_markers = { '.clangd', 'compile_commands.json' },
    filetypes = {'c', 'cpp', 'h', 'hpp'}
})


vim.lsp.enable("clangd")

		    	
