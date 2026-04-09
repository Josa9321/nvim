require('render-markdown').setup({
  latex = {
    enabled = true,
    converter = {'utftex'}, --, 'latex2text'},
    position = 'above',  -- renders cleanly above the raw block
  },
})
-- require('render-markdown').setup({
--     latex = {
--         enabled = true,
--         converter = { 'latex2text' },
--         highlight = 'RenderMarkdownMath',
--         position = 'center',
--         top_pad = 0,
--         bottom_pad = 0,
--     },
-- })
