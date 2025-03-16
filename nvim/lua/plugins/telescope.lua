return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.config.telescope")
        end,
    },
    { "nvim-telescope/telescope-frecency.nvim",   version = "*" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
