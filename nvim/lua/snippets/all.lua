local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

return {
    s("idk", {t("¯\\_(ツ)_/¯")}),
    s("crab", {t("🦀")}),
    s(
        "date",
        {
            f(
                function()
                    return vim.fn.strftime("%Y-%m-%d")
                end,
                {}
            ),
        }
    ),
    s("me", t "Alfonso Ros <alfonso.ros@esrlabs.com>"),
}
