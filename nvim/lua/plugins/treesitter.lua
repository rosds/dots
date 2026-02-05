return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter",
        lazy = false,
        branch = "main",
        config = function()
            require("plugins.config.treesitter")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
}
