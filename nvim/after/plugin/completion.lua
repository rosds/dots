--------------------------------------------------------------------------------
-- nvim-cmp
--------------------------------------------------------------------------------

local cmp = require("cmp")
local ls = require("luasnip")

local select_next_then_jump = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif ls and ls.expand_or_jumpable() then
        ls.expand_or_jump()
    else
        fallback()
    end
end

local select_prev_then_jump = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif ls.jumpable(-1) then
        ls.jump(-1)
    else
        fallback()
    end
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        -- select_prev
        ["<c-p>"] = cmp.mapping(select_prev_then_jump, { "i", "s" }),
        -- select_next
        ["<tab>"] = cmp.mapping(select_next_then_jump, { "i", "s" }),
        ["<c-n>"] = cmp.mapping(select_next_then_jump, { "i", "s" }),
        -- scroll docs
        ["<c-u>"] = cmp.mapping.scroll_docs(-4),
        ["<c-d>"] = cmp.mapping.scroll_docs(4),
        -- abort completion
        ["<c-e>"] = cmp.mapping.close(),
        -- take suggestion or exmand snippet
        ["<c-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                })
            elseif ls and ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        -- Take copilot completion
        ["<c-f>"] = function(fallback)
            cmp.mapping.abort()
            local copilot_keys = vim.fn["copilot#Accept"]()
            if copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                fallback()
            end
        end,
        -- luasnip choices
        ["<c-h>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
                require("luasnip.extras.select_choice")()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<c-l>"] = cmp.mapping(function(fallback)
            if ls and ls.expandable() then
                ls.expand({})
            elseif ls.choice_active() then
                ls.change_choice(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<c-o>"] = cmp.mapping(function(fallback)
            if ls.choice_active() then
                ls.change_choice(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer",  keyword_length = 5 },
        { name = "orgmode" },
        { name = "emoji" },
    },
    matching = {
        disallow_prefix_unmatching = false,
    },
    sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    window = {
        -- documentation = cmp.config.window.bordered(),
        -- completion = cmp.config.window.bordered(),
    },
    experimental = { native_menu = false, ghost_text = false },
})
