return {
    -- better ui
    {
        "stevearc/dressing.nvim",
        opts = {},
        event = "VeryLazy",
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

    -- lua
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

    -- tmux
    {
        "christoomey/vim-tmux-navigator",
        init = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end,
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

    -- rust
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false, -- This plugin is already lazy
    },

    -- zig
    { "ziglang/zig.vim",                                      ft = "zig" },

    -- jinja
    {
        "HiPhish/jinja.vim",
        build = "git submodule update --init --recursive",
        config = function()
            -- Set autogroup using neovim lua api for jinja file type
            local group = vim.api.nvim_create_augroup("jinja_group", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "jinja",
                group = group,
                callback = function(event)
                    vim.cmd([[

                        if !get(b:, 'jinja_syntax_autocmd_loaded', v:false)
                                if luaeval("vim.treesitter.language.get_lang('jinja')") == v:null
                                        autocmd FileType <buffer> if !empty(&ft) | setlocal syntax=on | endif
                                endif
                                let b:jinja_syntax_autocmd_loaded = v:true
                        endif
                    ]])
                end,
            })
        end

    },

    -- misc
    { "norcalli/nvim-colorizer.lua",                          cmd = "ColorizerToggle" },

    -- my plugins
    { enabled = false,                                        dir = "~/apex/apex.nvim" },
    { enabled = false,                                        dir = "~/apex/apexcolors.nvim" },

    -- { enabled = false,               dir = "~/apex/apex_gitlab.nvim", config = true, name = "apex_gitlab", main = "apex_gitlab" },
    { url = "git@gitlab.apex.ai:alfonso.ros/gitlab.nvim.git", config = true },
    {
        'alexander-born/bazel.nvim',
        name = "gh_bazel",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
        config = function()
            vim.g.bazel_cmd = "bazel"
        end
    },
    {
        dir = "~/bazel.nvim",
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
}
