return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- 'antosha417/nvim-lsp-file-operations',
        -- 's1n7ax/nvim-window-picker',
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                     -- neo-tree will lazily load itself

    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
            },
        },
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function()
                    vim.opt_local.relativenumber = true
                end,
            }
        },
    },


    -- keymap
    vim.keymap.set("n", "<leader>pv", function()
        -- Check if a Neo-tree window exists
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")

            if buf_ft == "neo-tree" then
                vim.cmd("Neotree close")
                return
            end
        end

        -- Otherwise open it
        vim.cmd("Neotree left")
    end)



}
