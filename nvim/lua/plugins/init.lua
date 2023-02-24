vim.g.firenvim_config = {
    globalSettings = {
        cmdlineTimeout = 3000,
    },
    localSettings = {
        ["https?://gitlab\\.apex\\.ai/"] = {
            takeover = "nonempty",
            priority = 1,
            content = "text",
            renderer = "html",
            selector = "textarea[id=issue-description]",
        },
        [".*"] = {
            takeover = "never",
            priority = 0,
        },
    },
}

return {
    -- telescope
    { "nvim-telescope/telescope.nvim",            dependencies = "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- LSP
    { "williamboman/mason.nvim",                  lazy = true },
    { "williamboman/mason-lspconfig.nvim",        lazy = true },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    { "j-hui/fidget.nvim",        tag = "legacy" },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup()
        end,
    },

    -- linting & formatting
    "jose-elias-alvarez/null-ls.nvim",

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
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "machakann/vim-sandwich",
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end,
    },

    -- git
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-unimpaired",

    -- lua
    { "rafcamlet/nvim-luapad", lazy = true },
    "folke/neodev.nvim",

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
        enabed = true,
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
        ft = { "markdown" },
        build = "cd app && npm install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

    -- Org Mode
    { "nvim-orgmode/orgmode",  ft = "org" },

    -- dap
    { "mfussenegger/nvim-dap", lazy = true },

    -- fennel
    { "rktjmp/hotpot.nvim",    lazy = true },

    -- rust
    {
        "rust-lang/rust.vim",
        lazy = true,
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },

    -- zig
    { "ziglang/zig.vim",             ft = "zig" },

    -- bazel
    {
        "bazelbuild/vim-bazel",
        dependencies = "google/vim-maktaba",
    },

    -- my plugins
    { dir = "~/apex/apex.nvim" },
    { dir = "~/apex/apexcolors.nvim" },
    { dir = "~/apex/gitlab.nvim",    config = true },
    {
        dir = "~/apex/bazel.nvim",
        config = function()
            require("bazel").setup()
            local n = require("keymaps").normal
            n({
                ["<leader>bb"] = { "<cmd>BazelBuild<cr>", desc = "BazelBuild" },
                ["<leader>bt"] = { "<cmd>BazelTest<cr>", desc = "BazelTest" },
                ["<leader>br"] = { "<cmd>BazelRun<cr>", desc = "BazelRun" },
            })
        end,
    },

    -- misc
    {
        "tpope/vim-dispatch",
        init = function()
            vim.g.dispatch_no_maps = 1
        end,
    },
    "jbyuki/venn.nvim",
    "dhruvasagar/vim-table-mode",
    {
        "glacambre/firenvim",
        cond = not not vim.g.started_by_firenvim,
        build = function()
            vim.fn["firenvim#install"](0)
        end,
    },
    { "norcalli/nvim-colorizer.lua" },
}
