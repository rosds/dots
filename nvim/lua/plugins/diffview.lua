return {
    {
        "sindrets/diffview.nvim",
        opts = {
            keymaps = {
                file_history_panel = {
                    {
                        "n",
                        "<c-n>",
                        function()
                            require("diffview.actions").select_next_entry()
                        end,
                    },
                    {
                        "n",
                        "<c-p>",
                        function()
                            require("diffview.actions").select_prev_entry()
                        end,
                    },
                },
            },
        },
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        keys = {
            { "<leader>gd", ":DiffviewFileHistory %<cr>" },
        },
    },
}
