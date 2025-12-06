local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

local in_text = function()
    return not in_mathzone()
end

return {
    s(
        { trig = 'ttt', dscr = "Expand 'tt' into '\texttt' ", condition=in_text },
        fmta(
            '\\texttt{<>}',
            { d(1, get_visual) }
        )
    ),
    s(
        { trig = 'tit', dscr = "Expand 'it' into '\textit' ", condition=in_text },
        fmta(
            '\\textit{<>}',
            { d(1, get_visual) }
        )
    ),
    s(
        { trig = 'tbf', dscr = "Expand 'bf' into '\textbf' ", condition=in_text },
        fmta(
            '\\textbf{<>}',
            { d(1, get_visual) }
        )
    ),
}
