local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("fn", fmt( "function(){}end", i(1))),
    s(
        "re",
        fmt("local {} = require('{}')",
            {
                d(
                    2,
                    function(args)
                        local pos = 1
                        local str = args[1][1]
                        local point = string.byte(".")
                        for idx = 1, #str do
                            if str:byte(idx) == point then
                                pos = idx + 1
                            end
                        end
                        return sn(nil, i(1, str:sub(pos)))
                    end,
                    {1}
                ),
                i(1),
            }
        )
    ),
}
