return {
    {
        "stevearc/oil.nvim",
        dependencies = { "echasnovski/mini.icons", "nvim-telescope/telescope.nvim" },
        config = function()
            require("plugins_config.oil")
        end,
    },
}
