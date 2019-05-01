local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s(
        "q",
        fmt(
            [[
                 ({}): {}
                ↳ ({}): {}
            ]],
            {
                i(1, "Bob"),
                i(2, "Bob's question"),
                i(3, "Alice"),
                i(4, "Alice's answer"),
            }
        )
    ),
    s(
        "src",
        fmt(
            [[
                #+BEGIN_SRC {}
                {}
                #+END_SRC
            ]],
            {
                i(1, "python"),
                i(2, "print('Hello world')"),
            }
        )
    ),
}
