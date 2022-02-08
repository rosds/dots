local cmp = require 'cmp'
local ls = require 'luasnip'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

cmp.setup {
    snippet = {expand = function(args) ls.lsp_expand(args.body) end},

    mapping = {
        ['<c-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif ls.jumpable(-1) then
                ls.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"}),
        ['<c-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif ls and ls.expand_or_jumpable() then
                ls.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ['<c-u>'] = cmp.mapping.scroll_docs(-4),
        ['<c-d>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.close(),
        ['<c-y>'] = function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                })
            else
                fallback()
            end
        end,
        -- Take copilot completion
        ['<c-f>'] = function(fallback)
            cmp.mapping.abort()
            local copilot_keys = vim.fn["copilot#Accept"]()
            if copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                fallback()
            end
        end,
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    sources = {
        {name = 'nvim_lsp'}, {name = 'nvim_lua'}, {name = 'luasnip'},
        {name = 'path'}, {name = 'buffer', keyword_length = 5}
    },

    experimental = {native_menu = false, ghost_text = false}
}
