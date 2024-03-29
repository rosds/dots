return {
    -- autocomplete
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",

    -- linting & formatting
    "nvimtools/none-ls.nvim",

    -- better ui
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },

    -- snippets
    "L3MON4D3/LuaSnip",
    { "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },

    -- life quality
    {
        "inkarkat/vim-mark",
        dependencies = "inkarkat/vim-ingo-library",
        init = function()
            vim.g.mw_no_mappings = 1
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "machakann/vim-sandwich",
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end,
    },

    -- git
    "tpope/vim-rhubarb",
    "tpope/vim-unimpaired",

    -- lua
    { "rafcamlet/nvim-luapad", cmd = "Luapad" },
    { "folke/neodev.nvim", opts = {} },

    -- tmux
    {
        "christoomey/vim-tmux-navigator",
        init = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end,
    },

    -- copilot
    {
        "github/copilot.vim",
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            vim.g.copilot_filetypes = {
                ["*"] = false,
                lua = true,
            }
        end,
    },

    -- markdown
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },
    {
        "dhruvasagar/vim-table-mode",
        init = function()
            vim.g.table_mode_default_mappings = 1
        end,
        cmd = {
            "TableModeEnable",
        },
    },

    -- fennel
    { "rktjmp/hotpot.nvim", ft = "fennel" },

    -- rust
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    -- zig
    { "ziglang/zig.vim", ft = "zig" },

    -- my plugins
    { dir = "~/apex/apex.nvim" },
    { dir = "~/apex/apexcolors.nvim" },
    { dir = "~/apex/gitlab.nvim", config = true },
    {
        dir = "~/apex/bazel.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/overseer.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local bazel = require("bazel")
            local themes = require("telescope.themes")
            bazel.setup()
            local n = require("keymaps").normal
            n({
                ["<leader>ba"] = {
                    function()
                        bazel.build(themes.get_ivy())
                    end,
                    desc = "BazelBuild",
                },
                ["<leader>bb"] = {
                    function()
                        bazel.build_package(themes.get_ivy())
                    end,
                    desc = "BazelBuild",
                },
                ["<leader>bt"] = {
                    function()
                        bazel.test_package(themes.get_ivy())
                    end,
                    desc = "BazelTest",
                },
                -- ["<leader>bb"] = { "<cmd>BazelBuild<cr>", desc = "BazelBuild" },
                ["<leader>br"] = { "<cmd>BazelRun<cr>", desc = "BazelRun" },
            })
        end,
    },

    -- misc
    "jbyuki/venn.nvim",
    { "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },
}
