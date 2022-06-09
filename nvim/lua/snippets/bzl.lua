local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmt

local function get_dirname()
    local path = vim.fn.expand('%:p:h')
    local dirname = vim.fn.fnamemodify(path, ':t')
    return dirname
end

return {
    s(
        "pl",
        fmt([[
        py_library(
            name = "{}",
            srcs = glob(["{}/**/*.py"]),
            imports = ["."],
            visibility = ["//visibility:public"],
        )
        ]], {
            -- i(1, get_dirname()),
            d(
                1,
                function()
                    return sn(nil, {
                        i(1, get_dirname()),
                    })
                end
            ),
            f(
                function(args)
                    return args[1][1]
                end,
                { 1 }
            ),
        })
    ),
}
