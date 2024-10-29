return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false,
        version = "*", -- Pin Neorg to the latest stable release
        config = function()
            require("plugins.config.neorg")
        end,
    },
}
