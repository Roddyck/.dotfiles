require("luasnip.session.snippet_collection").clear_snippets "tex"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local l = require("luasnip.extras").lambda

local conds_expand = require("luasnip.extras.conditions.expand")

local function math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

ls.add_snippets("tex", {
    s("template",
        fmta(
            [[
            \documentclass[a4paper]{article}
            \usepackage[a4paper,%
                text={180mm, 260mm},%
                left=15mm, top=15mm]{geometry}
            \usepackage[utf8]{inputenc}
            \usepackage{cmap}
            \usepackage[english, russian]{babel}
            \usepackage{indentfirst}
            \usepackage{amssymb}
            \usepackage{amsmath}
            \usepackage{mathtools}
            \usepackage{tcolorbox}

            \begin{document}
                <>
            \end{document}
            ]],
            { i(0) }),
            { condition=conds_expand.line_begin }
    ),

    s("mk", fmt("$ {} $ {}", { i(1), i(0) })),
    s("dm",
        fmt(
            [[
            \[
                {}
            \]
            ]],
            { i(0) })
    ),
    s("case",
        fmta(
            [[
                \begin{cases}
                    <>
                \end{cases}
            ]],
            { i(0) },
            { condition=math }
        )
    ),
    s("box",
        fmta(
            [[
                \begin{tcolorbox}
                    <>
                \end{tcolorbox}
            ]],
            { i(0) }
        )
    ),

    s({ trig="=>", wordTrig=false }, t("\\implies"), { condition=math }),
    s({ trig="<=", wordTrig=false }, t("\\impliedby"), { condition=math }),
    s({ trig="iff", wordTrig=false }, t("\\iff"), { condition=math }),
    s({ trig="~~", wordTrig=false }, t("\\approx"), { condition=math }),
    s("!>", t("\\mapsto"), { condition=math }),

    s("//", fmta("\\frac{<>}{<>} <>", { i(1), i(2), i(0) }), { condition=math }),
    s("d/dx", fmta("\\frac{\\partial <>}{\\partial <>} <>", { i(1, "u"), i(2, "x"), i(0) }), { condition=math }),

    s("ooo", t("\\infty"), { condition=math }),

    s("AA", t("\\forall"), { condition=math }),
    s("EE", t("\\exists"), { condition=math }),
    s("cc", t("\\subset"), { condition=math }),
    s("OO", t("\\varnothing"), { condition=math }),
    s("\\\\", t("\\setminus"), { condition=math }),

    s("RR", t("\\mathbb{R}"), { condition=math }),
    s("CC", t("\\mathbb{C}"), { condition=math }),
    s("ZZ", t("\\mathbb{Z}"), { condition=math }),
    s("NN", t("\\mathbb{N}"), { condition=math }),

    s({ trig="sr", wordTrig=false }, t("^2"), { condition=math }),
    s({ trig="cb", wordTrig=false }, t("^3"), { condition=math }),
    s({ trig="td", wordTrig=false }, fmta("^{<>}<>", { i(1), i(0) }), { condition=math }),

    s("fun", fmt("{}: {} \\to {}: {} {}", { i(1, "f"), i(2), i(3), i(4), i(0) }), { condition=math }),
    s("lim", fmta("\\lim_{<> \\to <>} <>", { i(1, "n"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("sum", fmta("\\sum_{i=<>}^{<>} <>", { i(1, "1"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("prod", fmta("\\prod_{i=<>}^{<>} <>", { i(1, "1"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("dint", fmta("\\int_{<>}^{<>} <>", { i(1, "-\\infty"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("sq", fmta("\\sqrt{<>} <>", { i(1), i(0) }), { condition=math }),

    s("__", fmta("_{<>}<>", { i(1), i(0) }), { condition=math }),

    postfix("tilde", { l("\\tilde{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("hat", { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("bar", { l("\\overline{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("under", { l("\\underline{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("vec", { l("\\vec{" .. l.POSTFIX_MATCH .. "}") }),

    s({ trig='(%a)(%d)', regTrig=true, name='auto subscript', dscr='auto subscript'},
        fmt([[<>_<>]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end) },
        { delimiters='<>' }),
        { condition=math }
    ),
    s({ trig='(%a)_(%d%d)', regTrig=true, name='auto subscript 2', dscr='auto subscript for 2+ digits'},
        fmt([[<>_{<>}]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end)},
        { delimiters='<>' }),
        { condition=math }
    ),

}, {
    type = "autosnippets",
})
