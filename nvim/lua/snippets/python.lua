local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function uuidgen()
    return vim.fn.trim(vim.fn.system("uuidgen"))
end

return {
    s("cr", t({ "# Copyright 2024 Apex.AI, Inc.", "# All rights reserved." })),
    s(
        "test",
        fmt(
            [[
    def {}(record_property):
        record_property("TEST_ID", "{}")
    ]],
            {
                i(1, "test_name"),
                f(function()
                    return uuidgen()
                end, {}),
            }
        )
    ),
}
