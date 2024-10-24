return {
    {
        "sindrets/diffview.nvim",
        config = function()
            require("plugins_config.diffview")
        end,
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", ":DiffviewFileHistory %<cr>" },
            { "<leader>gd", ":DiffviewFileHistory %<cr>" },
        },
    },
}
