local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("fn", fmt("function(){}end", i(1))),
    s("ld", fmt("(λ {} [{}] {})", {
        i(1, "name"),
        i(2, "arg"),
        i(3, "(print arg)")
    })),
}
