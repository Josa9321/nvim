return {
    {
        'nvim-telescope/telescope.nvim',
        tag = 'v0.1.9',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-bibtex.nvim",
        config = function()
            require("telescope").load_extension("bibtex")
        end,
    }
}
