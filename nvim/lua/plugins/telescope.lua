return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("plugins.config.telescope")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-frecency.nvim", version = "*" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },
}
