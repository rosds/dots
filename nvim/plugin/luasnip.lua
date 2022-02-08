local ls = require 'luasnip';
local cmp = require 'cmp';

ls.config.set_config {
    history = true,
}

-- some shorthands...
local s = ls.snippet
local t = ls.text_node

local snippets = {}
snippets.all = R 'snippets.all'
snippets.lua = R 'snippets.lua'
snippets.rust = R 'snippets.rust'
ls.snippets = snippets

table.insert(snippets.all, s("foo", t("bar")))
table.insert(snippets.all, s("pepe", t("juan")))
