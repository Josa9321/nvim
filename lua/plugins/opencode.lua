return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    config = function()
        ---@type opencode.Opts
        vim.g.opencode_opts = {
            -- Your configuration, if any; goto definition on the type or field for details
        }

        vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

        -- Recommended/example keymaps
        vim.keymap.set("n", "<leader>oa", function()
            vim.cmd("tabnew")
            require("opencode").ask("@this: ")
        end, { desc = "Open OpenCode in a full new tab" })
        vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,
            { desc = "Select OpenCode…" })

        vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
            { desc = "Append range to OpenCode", expr = true })
        vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
            { desc = "Append line to OpenCode", expr = true })

        vim.keymap.set({ "n", "t" }, "<C-,>", function() require("opencode").command("session.half.page.up") end,
            { desc = "Scroll OpenCode up" })
        vim.keymap.set({ "n", 't' }, "<C-.>", function() require("opencode").command("session.half.page.down") end,
            { desc = "Scroll OpenCode down" })
    end,
}
