local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end

local tex_utils = {}
tex_utils.in_mathzone = function() -- math context detection
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
    return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function() -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

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
        { trig = 'fig', dscr = 'Make a figure environment', snippetType = 'autosnippet', condition = line_begin },
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
        { trig = 'tab', dscr = 'Make a table environment', snippetType = 'autosnippet', condition = line_begin },
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
    s(
        {trig = ";i", snippetType='autosnippet', condition = tex_utils.in_itemize},
        fmta('\\item <>', {d(1, get_visual)})
    ),
    s("ls", {
        t({ "\\begin{itemize}", "\t\\item " }),
        i(1),
        d(2, rec_ls, {}),
        t({ "", "\\end{itemize}" }),
    }),
}
