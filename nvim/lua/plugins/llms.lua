return {
    -- copilot
    {
        "github/copilot.vim",
        enabled = false,
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = true,
        config = function()
            require("plugins.config.copilot")
        end,
    },

    -- chat
    {
        "olimorris/codecompanion.nvim",
        enabled = false,
        config = function()
            require("plugins.config.codecompanion")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "yetone/avante.nvim",
        build = "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        config = function()
            require("plugins.config.avante")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "stevearc/dressing.nvim",        -- for input provider dressing
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",        -- for providers='copilot'
        },
    }
}
