return {
    { "EdenEast/nightfox.nvim", lazy = true },
    { "catppuccin/nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
    { "morhetz/gruvbox", lazy = true },
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        init = function()
            vim.g.everforest_background = "hard"
        end,
    },
}
