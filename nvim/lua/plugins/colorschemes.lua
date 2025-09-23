return {
    { "EdenEast/nightfox.nvim", lazy = true },
    { "catppuccin/nvim",        lazy = true },
    { "folke/tokyonight.nvim",  lazy = true },
    { "morhetz/gruvbox",        lazy = true },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local transparent = not (vim.g.neovide or vim.g.started_by_firenvim)
            -- disable transparent for a change
            require("kanagawa").setup({ transparent = transparent })

            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        "sainnhe/gruvbox-material",
        init = function()
            vim.g.gruvbox_material_background = "soft"
            vim.g.gruvbox_material_foreground = "mix"

            if not vim.g.neovide then
                vim.g.gruvbox_material_transparent_background = 1
            end
        end,
    },
    {
        "sainnhe/everforest",
        lazy = true,
        init = function()
            vim.g.everforest_background = "hard"
        end,
    },
}
