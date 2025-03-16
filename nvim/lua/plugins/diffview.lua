return {
    {
        "sindrets/diffview.nvim",
        config = function()
            require("plugins.config.diffview")
        end,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gdd", ":DiffviewFileHistory %<cr>" },
            { "<leader>gdh", ":DiffviewFileHistory<cr>" },
        },
    },
}
