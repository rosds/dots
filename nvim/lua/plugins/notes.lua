return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/vaults/notes/*.md",
            "BufNewFile " .. vim.fn.expand("~") .. "/vaults/notes/*.md",
        },
        cmd = { "ObsidianSearch", "ObsidianToday" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("plugins.config.obsidian")
        end,
        keys = {
            {
                "<leader>nn",
                function()
                    require("plugins.config.obsidian").take_note()
                end,
            },
            { "<leader>ns", ":ObsidianSearch<CR>" },
        },
    },
}
