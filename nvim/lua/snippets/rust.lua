local ls = require("luasnip")
local tsquery = vim.treesitter.query

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local camel2snake = require("utils.string").camel2snake

local utils = require('snip_util')
local node_msg = utils.node_msg

local function query_structs()
    local parser = vim.treesitter.get_parser()
    local tstree = parser and parser:parse()[1]
    local root = tstree and tstree:root()
    local expr = [[
        (struct_item
            name: (_) @st-name
            (type_parameters (_) )? @st-type-parameters
        )
    ]]
    local names = {}
    local query = tsquery.parse_query("rust", expr)
    for _, match, _ in query:iter_matches(root, 0) do
        local name = {}
        for id, node in pairs(match) do
            if query.captures[id] == "st-name" then
                table.insert(name, 1, tsquery.get_node_text(node, 0))
            elseif query.captures[id] == "st-type-parameters" then
                table.insert(name, 2, tsquery.get_node_text(node, 0))
            end
        end
        if name then
            table.insert(names, vim.fn.join(name, ""))
        end
    end
    return names
end

return {
    s(
        "opt",
        fmt("Option<{}>", i(1))
    ),
    s(
        "res",
        fmt("Result<{}>", i(1))
    ),
    s(
        "st",
        fmt(
            [[
                {}struct {} {{
                    {}
                }}
            ]],
            {
                c(1,
                    {
                        t "",
                        fmt("#[derive({})]\n\n", i(1, "Debug"))
                    },
                    node_msg(" <- #[derive(...)]")
                ),
                i(2, "NewType"),
                i(0),
            }
        )
    ),
    s(
        "imp",
        fmt(
            [[
                impl{} {} {{
                    {}
                }}
            ]],
            {
                f(
                    function(args)
                        local _, _, generics = string.find(args[1][1], "%a+(<.+>)")
                        return generics or ""
                    end,
                    { 1 }
                ),
                d(1,
                    function()
                        local structs = query_structs()
                        if #(structs) == 0 then
                            return sn(nil, i(1, "NewType"))
                        end
                        local choices = {}
                        for _, name in pairs(structs) do
                            table.insert(choices, t(name))
                        end
                        table.insert(choices, i(1, "NewType"))
                        return sn(nil, c(1, choices))
                    end,
                    {}
                ),
                i(0),
            }
        )
    ),
    s("a", fmt("{}: {}", {
        d(2,
            function(arg)
                local camel = camel2snake(arg[1][1]:match('%a+'))
                return sn(nil, i(1, camel or "arg"))
            end,
            { 1 }),
        i(1, "Arg")
    }))
}
