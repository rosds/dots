return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
        config = function()
            require("plugins_config.oil")
        end,
    },
}
