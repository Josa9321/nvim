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
                    aerial = {
                        -- Set the width of the first two columns (the second
                        -- is relevant only when show_columns is set to 'both')
                        col1_width = 4,
                        col2_width = 30,
                        -- How to format the symbols
                        format_symbol = function(symbol_path, filetype)
                            if filetype == "json" or filetype == "yaml" then
                                return table.concat(symbol_path, ".")
                            else
                                return symbol_path[#symbol_path]
                            end
                        end,
                        -- Available modes: symbols, lines, both
                        show_columns = "both",
                    },
                },
            })
            require("telescope").load_extension("aerial")
            require("telescope").load_extension("bibtex")
            require("telescope").load_extension("ui-select")
        end,
    }
}
