return {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    cmd = "SymbolsOutline",
    keys = {
        { "<leader>so", "<cmd>SymbolsOutline<cr>" },
    },
    config = function()
        require("plugins.config.symbols-outline").setup()
    end,
}
