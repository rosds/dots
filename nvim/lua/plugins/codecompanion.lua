return {
    {
        "olimorris/codecompanion.nvim",
        config = function()
            require("plugins.config.codecompanion")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
