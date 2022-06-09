local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local sn = ls.snippet_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt
local extras = require('luasnip.extras')

local function inc_guard_name()
    local fname = vim.fn.expand("%:t")
    return fname:gsub("%.", "_"):upper()
end

return {
    s("in", {
        t("#include "),
        c(1, {
            sn(nil, { t("<"), r(1, "include_text"), t(">") }),
            sn(nil, { t('"'), r(1, "include_text"), t('"') }),
        }),
    }, {
        stored = {
            ["include_text"] = i(1, "iostream"),
        }
    }),
    s("up", fmt("std::unique_ptr<{}>", { i(1, "Foo") })),
    s("sp", fmt("std::shared_ptr<{}>", { i(1, "Foo") })),
    s(
        "ns",
        fmt([[
            namespace {} {{
              {}
            }}  // namespace {}
        ]], {
            i(1, "foo"),
            i(2),
            extras.rep(1),
        })
    ),
    s("ig", fmt([[
        #ifndef {}
        #define {}
        {}
        #endif  // {}
    ]], {
        d(1, function() return sn(nil, i(1, inc_guard_name())) end),
        extras.rep(1),
        i(2),
        extras.rep(1),
    })),

    -- apex snippets
    s("cr", t({'// Copyright 2022 Apex.AI, Inc.', '// All rights reserved.', ''})),
    s(
        "anode",
        fmt([[
        class {} : public apex::executor::apex_node_base
        {{
        public:
          explicit {}(
            const apex::string_strict256_t & name)
          : apex::executor::apex_node_base{{name.c_str()}}
          {{}}

        protected:
          void execute_impl() override
          {{
            {}
          }}
        }};
        ]], {
            i(1, "MyNode"),
            extras.rep(1),
            i(2, "// TODO: implement execute_impl"),
        })
    ),
}
