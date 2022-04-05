local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("fn",
        fmt(
            [[
                {}function() {} end
            ]],
            {
                c(1, { t(""), sn(nil, fmt("local {} = ", i(1))), }),
                i(0),
            }
        )
    ),
}
