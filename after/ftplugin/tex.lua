local opt = vim.opt_local
local map = vim.keymap.set

opt.wrap = true

-- Buffer-local tweaks for TeX files
opt.spell = true
opt.spelllang = {'pt_br', "en_us"}


opt.tabstop=4
opt.sw=4
opt.linebreak=true
opt.breakindent=true

-- map('n', '<leader>rc', "<cmd>VimtexCompile<CR>")
map('n', '{', "{zz")
map('n', '}', "}zz")

local function texlab_request(method, desc)
    local client = vim.lsp.get_clients({ bufnr = 0, name = "texlab" })[1]
    if not client then
        vim.notify("Texlab not attached", vim.log.levels.WARN)
        return false
    end
    vim.lsp.buf_request(0, method,
        vim.lsp.util.make_position_params(0, client.offset_encoding),
        function(err)
            if err then
                vim.notify(desc .. " failed: " .. err.message, vim.log.levels.ERROR)
            end
        end)
    return true
end

map('n', '<leader>rc', function()
    texlab_request("textDocument/build", "Build")
end, { desc = "TeX: Build (Tectonic)" })

map("n", "<leader>rf", function()
    texlab_request("textDocument/forwardSearch", "Forward search")
end, { desc = "TeX: Forward search (Zathura)" })
