return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
            })
        end,
        keys = {
            {
                "<leader>hh",
                function()
                    require("neogen").generate({})
                end,
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
        lazy = true,
    },
}
