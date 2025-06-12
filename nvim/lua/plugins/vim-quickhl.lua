return {
    {
        "t9md/vim-quickhl",
        enabled = false,
        lazy = false,
        keys = {
            { "<leader>m", "<Plug>(quickhl-manual-this)" },
            { "<leader>m", "<Plug>(quickhl-manual-this)",  mode = "x" },
            { "<leader>M", "<Plug>(quickhl-manual-reset)" },
            { "<leader>M", "<Plug>(quickhl-manual-reset)", mode = "x" },
        },
    },
    {
        "inkarkat/vim-mark",
        lazy = false,
        init = function()
            vim.g.mw_no_mappings = 1
        end,
        keys = {
            { "<leader>m", "<Plug>MarkSet" },
            { "<leader>m", "<Plug>MarkSet",                mode = "x" },
            { "<leader>M", "<Plug>MarkAllClear" },
            { "<leader>M", "<Plug>(quickhl-manual-reset)", mode = "x" },
        },
        dependencies = {
            "inkarkat/vim-ingo-library",
        }
    }
}
