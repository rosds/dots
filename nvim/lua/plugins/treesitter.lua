local opts = {
    playground = { enable = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
    ensure_installed = { "lua", "rust", "cpp", "python", "markdown", "fennel", "json", "yaml" },
    ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
        enable = false,
        disable = { "vim" },
        keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<tab>",
            node_decremental = "<bs>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
            },
        },
    },
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = opts,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    { "nvim-treesitter/playground" },
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
            })
        end,
        keys = {
            {
                "<leader>hh",
                function()
                    require("neogen").generate({})
                end,
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
        lazy = true,
    },
}
