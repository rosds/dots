return {
    {
        "stevearc/overseer.nvim",
        config = function()
            require("plugins.config.overseer")
        end,
        version = "v1.6.0",
        keys = {
            { "<leader>tt", "<cmd>OverseerRun<cr>", desc = "" },
            { "<leader>to", "<cmd>OverseerToggle<cr>", desc = "" },
            { "<leader>tr", "<cmd>OverseerRestartLast<cr>", desc = "" },
            { "<leader>tv", "<cmd>OverseerOpenVSplitLast<cr>", desc = "" },
        },
    },
}
