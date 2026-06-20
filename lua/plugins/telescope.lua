return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.1.9',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' }
    },
    {
        "nvim-telescope/telescope-bibtex.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                        }
                    },
                },
            })
            require("telescope").load_extension("bibtex")
            require("telescope").load_extension("ui-select")
        end,
    }
}
