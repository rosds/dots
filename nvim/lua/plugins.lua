-- packerg bootstrapping
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

-- reload after safe
local ag = require('augroup').augroup
ag "packer_user_config" {
    {
        "BufWritePost",
        pattern = "plugins.lua",
        command = "source <afile> | PackerCompile",
        desc = "reload packer after modifications",
    },
}

return require('packer').startup(function(use)
    -- plugin management
    use 'wbthomason/packer.nvim'

    -- lua
    use 'nvim-lua/plenary.nvim'
    use 'rafcamlet/nvim-luapad'
    use 'folke/neodev.nvim'

    -- comments
    use 'numToStr/Comment.nvim'

    -- explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- telescope
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- lsp & completion
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use "neovim/nvim-lspconfig"
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-emoji'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'j-hui/fidget.nvim'

    -- linting & formatting
    use 'jose-elias-alvarez/null-ls.nvim'

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', }
    use { 'nvim-treesitter/playground' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- documentation
    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {
                snippet_engine = "luasnip",
                vim.keymap.set('n', '<leader>hh', function() require'neogen'.generate({}) end)
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter",
    }

    -- colorschemes
    use 'morhetz/gruvbox'
    use 'EdenEast/nightfox.nvim'

    -- apex plugins
    use '~/apex/apexcolors.nvim'
    use {
        '~/apex/gitlab.nvim',
        config = function()
            require('gitlab').setup({})
        end,
    }
    use '~/apex/apex.nvim'

    -- git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-unimpaired'

    -- tmux
    use {
        'christoomey/vim-tmux-navigator',
        setup = function()
            vim.g.tmux_navigator_disable_when_zoomed = 1
            -- vim.g.tmux_navigator_preserve_zoom = 1
        end
    }

    -- copilot
    use {
        'github/copilot.vim',
        setup = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            -- vim.g.copilot_filetypes = {
            --     cpp = false,
            -- }
        end
    }

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Org Mode
    use 'nvim-orgmode/orgmode'
    -- use 'nvim-neorg/neorg'

    -- live quality
    use {
        'inkarkat/vim-mark',
        requires = 'inkarkat/vim-ingo-library',
        setup = function() vim.g.mw_no_mappings = 1 end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require 'nvim-autopairs'.setup {} end
    }
    use "lukas-reineke/indent-blankline.nvim"
    use {
        'machakann/vim-sandwich',
        setup = function()
            vim.g.sandwich_no_default_key_mappings = 1
            vim.g.operator_sandwich_no_default_key_mappings = 1
        end
    }

    -- dap
    use 'mfussenegger/nvim-dap'

    -- fennel
    use 'rktjmp/hotpot.nvim'

    -- rust
    use 'simrat39/rust-tools.nvim'
    use {
        'rust-lang/rust.vim',
        setup = function() vim.g.rustfmt_autosave = 1 end
    }

    -- zig
    use 'ziglang/zig.vim'

    -- bazel
    use {
        'bazelbuild/vim-bazel',
        requires = 'google/vim-maktaba'
    }

    -- misc
    use {
        'tpope/vim-dispatch',
        setup = function() vim.g.dispatch_no_maps = 1 end
    }
    use 'jbyuki/venn.nvim'
    use 'dhruvasagar/vim-table-mode'
    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end,
        setup = function()
            vim.g.firenvim_config = {
                globalSettings = {
                    alt = 'all',
                },
                localSettings = {
                    ["https?://gitlab\\.apex\\.ai/"] = {
                        takeover = "nonempty",
                        priority = 1,
                        content = "markdown",
                        selector = "textarea[class~=markdown-area]",
                    },
                    [".*"] = {
                        takeover = "never",
                        priority = 0,
                    },
                },
            }
        end,
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
