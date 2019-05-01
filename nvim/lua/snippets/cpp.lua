local ls = require("luasnip")
local fs = require("utils.fs")
local Path = require("plenary.path")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local sn = ls.snippet_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")

local function inc_guard_name()
    local path = Path:new(fs.buffer_path())
    local maybe_workspace = path:find_upwards("WORKSPACE")

    local fname = ""
    if maybe_workspace == "" then
        fname = path.filename
    else
        fname = path:make_relative(maybe_workspace:parent().filename)
    end

    return fname:gsub("%/", "_"):gsub("%.", "_"):upper()
end

local function copy_right()
    return fmt(
        [[
        /// @copyright Copyright 2024 Apex.AI, Inc.
        /// All rights reserved.
        /// @file
        {}
        ]],
        { c(1, { { t("/// @brief "), i(1, "description") }, t("") }) }
    )
end

local function uuidgen()
    return vim.fn.trim(vim.fn.system("uuidgen"))
end

local function include_guard()
    return fmt(
        [[
        #ifndef {}
        #define {}
        {}
        #endif  // {}
    ]],
        {
            d(1, function()
                return sn(nil, i(1, inc_guard_name()))
            end),
            extras.rep(1),
            i(2),
            extras.rep(1),
        }
    )
end

local function new_file()
    return fmt(
        [[
    {}
    {}
    ]],
        { c(1, { copy_right(), t("") }), sn(2, include_guard()) }
    )
end

local function ctor(jump_idx)
    return sn(
        jump_idx,
        fmt(
            [[
            {}() = default;
            {}(const {}&) = delete;
            {}& operator=(const {}&) = delete;
            {}({}&&) noexcept = default;
            {}& operator=({}&&) noexcept = default;
            virtual ~{}() = default;
            ]],
            {
                i(1, "Foo"),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
            }
        )
    )
end

local function template_param(idx)
    return c(idx, {
        sn(nil, { t("typename "), i(1, "T") }),
        sn(nil, { i(1, "param") }),
    })
end

local function template_param_rec()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, { t({ ", " }), template_param(1), d(2, template_param_rec, {}) }),
        }),
    })
end

return {
    s("templ", {
        t("template <"),
        template_param(1),
        d(2, template_param_rec, {}),
        t({ ">", "" }),
    }),
    s("in", {
        t("#include "),
        c(1, {
            sn(nil, { t("<"), r(1, "include_text"), t(">") }),
            sn(nil, { t('"'), r(1, "include_text"), t('"') }),
        }),
    }, {
        stored = {
            ["include_text"] = i(1, "iostream"),
        },
    }),
    s("up", fmt("std::unique_ptr<{}>", { i(1, "Foo") })),
    s("sp", fmt("std::shared_ptr<{}>", { i(1, "Foo") })),
    s(
        "ns",
        fmt(
            [[
            namespace {} {{
              {}
            }}  // namespace {}
        ]],
            {
                i(1),
                i(2),
                extras.rep(1),
            }
        )
    ),
    s("once", include_guard()),

    -- apex snippets
    s("cr", copy_right()),

    -- empty file
    s("newfile", new_file()),

    s(
        "anode",
        fmt(
            [[
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
        ]],
            {
                i(1, "MyNode"),
                extras.rep(1),
                i(2, "// TODO: implement execute_impl"),
            }
        )
    ),
    s(
        "class",
        fmt(
            [[
        class {} {{
         public:
          {}() = default;
          {}(const {}&) = default;
          {}& operator=(const {}&) = default;
          {}({}&&) = default;
          {}& operator=({}&&) = default;
          virtual ~{}() = default;

          {}
        }};
        ]],
            {
                i(1, "Foo"),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                i(2, "// TODO: implement class"),
            }
        )
    ),
    s(
        "ctor",
        fmt(
            [[
            {}() = default;
            {}(const {}&) = delete;
            {}& operator=(const {}&) = delete;
            {}({}&&) noexcept = default;
            {}& operator=({}&&) noexcept = default;
            virtual ~{}() = default;
            ]],
            {
                i(1, "Foo"),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
            }
        )
    ),
    s(
        "test",
        fmt(
            [[
            TEST({}, {})
            {{
              ::testing::Test::RecordProperty("TEST_ID", "{}");
              {}
            }}
        ]],
            {
                i(1, "Foo"),
                i(2, "Bar"),
                f(uuidgen, {}),
                i(3, "// TODO: implement test"),
            }
        )
    ),
    s(
        "uuid",
        fmt('::testing::Test::RecordProperty("TEST_ID", "{}");', {
            f(uuidgen, {}),
        })
    ),
    s(
        "result",
        fmt(
            [[
        if (auto result = {expr}; result.has_error()) {{
            return base::err(base::move(result.error()));
        }}
        ]],
            {
                expr = i(1, "expr()"),
            }
        )
    ),
    s(
        "lerr",
        fmt(
            'BASE_LOG(ERROR, "{}"{});',
            { i(1, "error message"), c(2, { { t(" << "), i(1, "result.error()") }, t("") }) }
        )
    ),
    s("linfo", fmt('BASE_LOG(INFO, "{}");', { i(1, "info message") })),
    s(
        "rerr",
        fmt(
            'return apex::err("{}"{});',
            { i(1, "error message"), c(2, { { t(", "), i(1, "base::move(result.error())") }, t("") }) }
        )
    ),
    s("unimpl", t('return base::err(base::error("unimplemented"));')),
    s(
        "axivion",
        fmt("// AXIVION Next Construct {}: {}", {
            i(1, "AutosarC++19_03-M5.0.2"),
            i(2, "TODO reason"),
        })
    ),
}
