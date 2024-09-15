require("luasnip.session.snippet_collection").clear_snippets "tex"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt
local postfix = require("luasnip.extras.postfix").postfix
local l = require("luasnip.extras").lambda

ls.add_snippets("tex", {
    s("//", fmt("\\frac{[]}{[]} []", { i(1), i(2), i(0) }, { delimiters = "[]" })),
    postfix("tilde", { l("\\tilde{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("hat", { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("bar", { l("\\overline{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("under", { l("\\underline{" .. l.POSTFIX_MATCH .. "}") }),
    s({ trig='(%a)(%d)', regTrig=true, name='auto subscript', dscr='hi'},
        fmt([[<>_<>]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end) },
        { delimiters='<>' })
    ),
    s({ trig='(%a)_(%d%d)', regTrig=true, name='auto subscript 2', dscr='auto subscript for 2+ digits'},
        fmt([[<>_{<>}]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end)},
        { delimiters='<>' })
    ),

}, {
    type = "autosnippets",
    key = "all_auto",
})
