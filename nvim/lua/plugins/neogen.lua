return {

    {
        "danymat/neogen",
        config = function()
            require("plugins.config.neogen")
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
