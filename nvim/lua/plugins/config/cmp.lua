local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

local select_next_then_jump = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif ls and ls.expand_or_jumpable() then
        ls.expand_or_jump()
    else
        fallback()
    end
end

local jump_then_select_next = function(fallback)
    if ls and ls.expand_or_jumpable() then
        ls.expand_or_jump()
    elseif cmp.visible() then
        cmp.select_next_item()
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

local jump_then_select_prev = function(fallback)
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
            ls.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- select_prev
        ["<c-p>"] = cmp.mapping(jump_then_select_prev, { "i", "s" }),
        ["<c-k>"] = cmp.mapping(select_prev_then_jump, { "i", "s" }),
        -- select_next
        ["<tab>"] = cmp.mapping(select_next_then_jump, { "i", "s" }),
        ["<c-n>"] = cmp.mapping(jump_then_select_next, { "i", "s" }),
        ["<c-j>"] = cmp.mapping(select_next_then_jump, { "i", "s" }),
        -- scroll docs
        ["<c-u>"] = cmp.mapping.scroll_docs(-4),
        ["<c-d>"] = cmp.mapping.scroll_docs(4),
        -- abort completion
        ["<c-e>"] = cmp.mapping.close(),
        -- take suggestion or expand snippet
        ["<c-y>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                })
            elseif ls and ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                local copilot_keys = vim.fn["copilot#Accept"]()
                if copilot_keys ~= "" then
                    vim.api.nvim_feedkeys(copilot_keys, "i", true)
                else
                    fallback()
                end
            end
        end, { "i", "s" }),
        -- Take copilot completion
        -- ["<c-g>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.confirm({
        --             behavior = cmp.ConfirmBehavior.Insert,
        --             select = true,
        --         })
        --     else
        --         cmp.mapping.complete()
        --     end
        -- end),
        ["<c-g>"] = cmp.mapping.complete(),
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
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 5 },
        { name = "orgmode" },
        { name = "emoji" },
    },
    matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = true,
    },
    sorting = {
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
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    experimental = { native_menu = false, ghost_text = false },
    formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
