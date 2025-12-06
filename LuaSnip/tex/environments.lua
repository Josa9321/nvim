local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

return {
    s(
        { trig = 'h0', dscr = 'Make an chapter', snippetType = 'autosnippet', condition = line_begin },
        fmta('\\chapter{<>}', { d(1, get_visual) })
    ),
    s(
        { trig = 'h1', dscr = 'Make an section', snippetType = 'autosnippet', condition = line_begin },
        fmta('\\section{<>}', { d(1, get_visual) })
    ),
    s(
        { trig = 'h2', dscr = 'Make an subsection', snippetType = 'autosnippet', condition = line_begin },
        fmta('\\subsection{<>}', { d(1, get_visual) })
    ),
    s(
        { trig = 'h3', dscr = 'Make an subsubsection', snippetType = 'autosnippet', condition = line_begin },
        fmta('\\subsubsection{<>}', { d(1, get_visual) })
    ),
    s(
        { trig = 'al', dscr = 'Make an align environment', snippetType = 'autosnippet', condition = line_begin },
        fmta(
            [[
            \begin{align}
                <>
            \end{align}
            ]],
            { d(1, get_visual) }
        )
    ),
    s(
        { trig = 'env', dscr = 'Make a generic environment', snippetType = 'autosnippet', condition = line_begin },
        fmta(
            [[
            \begin{<>}
                <>
            \end{<>}
            ]],
            { i(1), i(2), rep(1) }
        )
    ),
    s(
        { trig = 'eq', dscr = 'Make an equation environment', snippetType = 'autosnippet', condition = line_begin },
        fmta(
            [[
            \begin{equation}
                <>
            \end{equation}
            ]],
            { d(1, get_visual) }
        )
    ),
    s(
        { trig = 'fig', dscr = 'Make an figure environment', snippetType = 'autosnippet', condition = line_begin },
        fmta(
            [[
            \begin{figure}[<>]
                \centering
                \includegraphics[width=0.5\linewidth]{<>}
                \caption{<>}
                \label{<>}
            \end{figure}
            ]],
            {
                i(1),
                i(2),
                i(3, "Caption"),
                i(4, "fig:placeholder")
            }
        )
    ),
    s(
        { trig = 'tab', dscr = 'Make an figure environment', snippetType = 'autosnippet', condition = line_begin },
        fmta(
            [[
            \begin{table}[<>]
                \centering
                \begin{tabular}{<>}
                     &  \\
                     & 
                \end{tabular}
                \caption{<>}
                \label{<>}
            \end{table}
            ]],
            {
                i(1),
                i(2, 'c|c'),
                i(3, "Caption"),
                i(4, "tab:placeholder")
            }
        )
    ),
}
