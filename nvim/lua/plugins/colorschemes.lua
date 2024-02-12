return {
    { "EdenEast/nightfox.nvim", lazy = true },
    { "catppuccin/nvim",        lazy = true },
    { "folke/tokyonight.nvim",  lazy = true },
    { "rebelot/kanagawa.nvim",  lazy = true },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        init = function()
            vim.g.gruvbox_material_background = "soft"
            vim.g.gruvbox_material_foreground = "mix"
        end,
    },
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
    },
    {
        "sainnhe/everforest",
        lazy = true,
        init = function()
            vim.g.everforest_background = "hard"
        end,
    },
}
