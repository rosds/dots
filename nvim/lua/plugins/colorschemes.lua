return {
    { "EdenEast/nightfox.nvim", lazy = true },
    { "catppuccin/nvim",        lazy = true },
    { "folke/tokyonight.nvim",  lazy = true },
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
