return {
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
        config = true,
    },

    -- git
    "tpope/vim-rhubarb",
    "tpope/vim-unimpaired",

    -- lua
    { "rafcamlet/nvim-luapad", cmd = "Luapad" },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta",  lazy = true }, -- optional `vim.uv` typings

    -- tmux
    {
        "christoomey/vim-tmux-navigator",
        init = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end,
    },

    -- Gitlab duo
    {
        "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git",
        enabled = false,
        -- Activate when a file is created/opened
        event = { "BufReadPre", "BufNewFile" },
        -- Activate when a supported filetype is open
        ft = { "sh", "cpp", "python" },
        cond = function()
            -- Only activate if token is present in environment variable.
            -- Remove this line to use the interactive workflow.
            return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ""
        end,
        opts = {
            statusline = {
                -- Hook into the built-in statusline to indicate the status
                -- of the GitLab Duo Code Suggestions integration
                enabled = false,
            },
        },
    },

    -- markdown
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
    { "rktjmp/hotpot.nvim",                                   ft = "fennel" },

    -- rust
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false, -- This plugin is already lazy
    },

    -- zig
    { "ziglang/zig.vim",                                      ft = "zig" },

    -- jinja
    { "HiPhish/jinja.vim",                                    ft = "jinja" },

    -- my plugins
    { dir = "~/apex/apex.nvim" },
    { dir = "~/apex/apexcolors.nvim" },
    -- { enabled = false,               dir = "~/apex/apex_gitlab.nvim", config = true, name = "apex_gitlab", main = "apex_gitlab" },
    { url = "git@gitlab.apex.ai:alfonso.ros/gitlab.nvim.git", config = true },
    {
        'alexander-born/bazel.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        config = function()
            vim.g.bazel_cmd = "bazel"
        end
    },
    -- {
    --     enabled = false,
    --     dir = "~/apex/bazel.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "stevearc/overseer.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     config = function()
    --         local bazel = require("bazel")
    --         bazel.setup({})
    --
    --         local bazel_telescope = require("bazel.telescope")
    --         local n = require("keymaps").normal
    --
    --         local themes = require("telescope.themes")
    --         n({
    --             ["<leader>ba"] = {
    --                 function()
    --                     bazel_telescope.build(themes.get_ivy())
    --                 end,
    --                 desc = "bazel build any target",
    --             },
    --             ["<leader>bb"] = {
    --                 function()
    --                     bazel_telescope.build_package(themes.get_ivy())
    --                 end,
    --                 desc = "bazel build package target",
    --             },
    --             ["<leader>bt"] = {
    --                 function()
    --                     bazel_telescope.test(themes.get_ivy())
    --                 end,
    --                 desc = "bazel test any target",
    --             },
    --         })
    --     end,
    -- },

    -- misc
    { "norcalli/nvim-colorizer.lua", cmd = "ColorizerToggle" },
}
