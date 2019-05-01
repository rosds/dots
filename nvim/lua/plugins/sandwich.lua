return {
    {
        "machakann/vim-sandwich",
        lazy = false,
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end,
        config = function()
            local m = require("keymaps").map
            local o = require("keymaps").operator

            m({
                ["<leader>wa"] = { "<Plug>(operator-sandwich-add)", noremap = false },
                ["<leader>wd"] = { "<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)", noremap = false },
                ["<leader>wr"] = {
                    "<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)",
                    noremap = false,
                },
            })

            o({
                ["ib"] = { "<Plug>(textobj-sandwich-auto-i)", noremap = false },
                ["ab"] = { "<Plug>(textobj-sandwich-auto-a)", noremap = false },
                ["is"] = { "<Plug>(textobj-sandwich-query-i)", noremap = false },
                ["as"] = { "<Plug>(textobj-sandwich-query-a)", noremap = false },
            })
        end,
    },
}
