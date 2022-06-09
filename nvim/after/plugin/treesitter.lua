local status, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter_configs.setup {
    playground = { enable = true },

    query_linter = {
        enable = true,

        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" }
    },

    ensure_installed = { "lua", "rust", "python" },
    ignore_install = { "javascript" }, -- List of parsers to ignore installing

    highlight = {
        enable = true,

        disable = { "c", "rust" }, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },

    incremental_selection = {
        enable = true,
        disable = { "vim" },
        keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<tab>",
            node_decremental = "<bs>"
        }
    },

    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner"
            }
        }
    }
}

require 'treesitter-context'.setup {}

-- use python parser on bazel files
local ft_to_parser = require 'nvim-treesitter.parsers'.filetype_to_parsername
ft_to_parser.bzl = "python"
