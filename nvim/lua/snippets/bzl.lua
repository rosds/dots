local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node

local fmt = require("luasnip.extras.fmt").fmt

local Path = require("plenary.path")

local function buf_path()
    return Path:new(vim.api.nvim_buf_get_name(0))
end

local function get_dirname()
    local path = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(path, ":p:h")
    return vim.fn.fnamemodify(dir, ":t")
end

local function glob(glob_expr)
    local dir = buf_path():parent()

    local sources = {}
    if type(glob_expr) == "table" then
        for _, glob_str in ipairs(glob_expr) do
            local globbed = vim.fn.glob(dir .. "/" .. glob_str, true, true)
            vim.list_extend(sources, globbed)
        end
    elseif type(glob_expr) == "string" then
        sources = vim.fn.glob(dir .. "/" .. glob_expr, true, true)
    else
        error("glob_expr must be a string or table")
    end

    local source_list = {}
    for _, source in ipairs(sources) do
        P(source)
        local rel_path = Path:new(source):make_relative(dir.filename)
        table.insert(source_list, '"' .. rel_path .. '",')
    end

    return source_list
end

return {
    s(
        "clib",
        fmt(
            [[
        cc_library(
            name = "{}",
            srcs = [{}],
            hdrs = [{}],
            visibility = [{}],
        )
        ]],
            {
                i(1, "lib_name"),
                f(function()
                    return glob({ "**/*.cpp", "**/*.hpp" })
                end, {}),
                i(2),
                c(3, {
                    t({ '"//visibility:private"' }),
                    t({ '"//visibility:public"' }),
                    sn(nil, { t({ '"' }), i(1), t({ '"' }) }),
                }),
            }
        )
    ),
    s(
        "ctest",
        fmt(
            [[
        cc_test(
            name = "{}",
            srcs = [{}],
            {}
        )
        ]],
            {
                i(1, "test_name"),
                f(function()
                    return glob({ "**/*.cpp", "**/*.hpp" })
                end),
                c(2, {
                    t({ "deps = [", '    "@googletest//:gtest_main"', "]," }),
                    t(""),
                }),
            }
        )
    ),
    s(
        "pylib",
        fmt(
            [[
        py_library(
            name = "{}",
            srcs = glob(["{}/**/*.py"]),
            imports = ["."],
            visibility = ["//visibility:public"],
        )
        ]],
            {
                -- i(1, get_dirname()),
                d(1, function()
                    return sn(nil, {
                        i(1, get_dirname()),
                    })
                end),
                f(function(args)
                    return args[1][1]
                end, { 1 }),
            }
        )
    ),
    s(
        "apex_srcs",
        fmt(
            [[
            load("//tools/bazel/rules_apex:defs.bzl", "apex_srcs")

            apex_srcs({}{})  # for Apex internal use only
            ]],
            {
                c(1, {
                    t({ "", '   maturity = "internal"' }),
                    t({ "", '   maturity = "experimental"' }),
                    t({ "", '   maturity = "draft"' }),
                    t({ "", '   maturity = "stable"' }),
                    t({ "", '   maturity = "manual"' }),
                    t(""),
                }),
                c(2, {
                    isn(
                        nil,
                        fmt(
                            [[
                            ,
                            skip_checkers = [
                                {}
                            ]
                            ]],
                            {
                                i(1, {
                                    '"clang-format",',
                                    '    "black",',
                                }),
                            }
                        ),
                        "$PARENT_INDENT    "
                    ),
                    t(""),
                }),
            }
        )
    ),
}
