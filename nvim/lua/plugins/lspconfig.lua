return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins_config.lspconfig")
        end,
        dependencies = {
            "j-hui/fidget.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },
}
