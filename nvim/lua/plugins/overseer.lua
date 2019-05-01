return {
    {
        "stevearc/overseer.nvim",
        config = function()
            require("plugins_config.overseer")
        end,
        keys = {
            { "<leader>tt", "<cmd>OverseerRun<cr>",            desc = "" },
            { "<leader>to", "<cmd>OverseerToggle<cr>",         desc = "" },
            { "<leader>tr", "<cmd>OverseerRestartLast<cr>",    desc = "" },
            { "<leader>tv", "<cmd>OverseerOpenVSplitLast<cr>", desc = "" },
        },
    },
}
