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
            require("notify").setup({
                background_colour = "#000000",
            })
            vim.notify = require("notify")
        end,
    },

    -- QoL
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
    },

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
            bazel.setup({})

            local bazel_telescope = require("bazel.telescope")
            local n = require("keymaps").normal

            local themes = require("telescope.themes")
            n({
                ["<leader>ba"] = {
                    function()
                        bazel_telescope.build(themes.get_ivy())
                    end,
                    desc = "bazel build any target",
                },
                ["<leader>bb"] = {
                    function()
                        bazel_telescope.build_package(themes.get_ivy())
                    end,
                    desc = "bazel build package target",
                },
                ["<leader>bt"] = {
                    function()
                        bazel_telescope.test(themes.get_ivy())
                    end,
                    desc = "bazel test any target",
                },
            })
        end,
    },

    -- misc
    "jbyuki/venn.nvim",
    { "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },
}
